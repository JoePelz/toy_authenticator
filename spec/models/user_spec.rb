# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:password) { 'h2f8057hro' }
  let(:password_confirmation) { password }
  let(:username) { 'test_user' }
  let(:user) do
    described_class.new(username: username, password: password, password_confirmation: password_confirmation)
  end

  describe 'validations' do
    subject { user.valid? }

    it { is_expected.to be true }

    context 'when the username is blank' do
      let(:username) { '' }

      it { is_expected.to be false }
    end

    context 'when the password_confirmation is missing' do
      let(:user) { described_class.new(username: username, password: password) }

      it { is_expected.to be false }
    end

    context 'when the username is taken' do
      let(:pre_existing_user) { described_class.new(username: username) }
      let(:mock_redis) { instance_double(Redis) }

      before do
        allow(RedisInstance).to receive(:instance).and_return(mock_redis)
        allow(mock_redis).to receive(:get).with(username).and_return(pre_existing_user)
      end

      it { is_expected.to be false }
    end

    context 'when the password is too short' do
      let(:password) { '>} 6' }

      it { is_expected.to be false }
    end

    context 'when the password is inadequately complex' do
      let(:password) { 'password' }

      it { is_expected.to be false }
    end
  end

  describe '.find_by' do
    subject { described_class.find_by(username: username) }

    context 'when the user exists' do
      around do |example|
        user.save
        example.run
        RedisInstance.instance.del(username)
      end

      it 'finds the user that matches the username' do
        expect(subject).to be_an_instance_of described_class
        expect(subject.attributes).to eq user.attributes
      end
    end

    context "when the user doesn't exist" do
      before { RedisInstance.instance.del(username) }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#save' do
    subject { user.save }

    let(:expected_serialization) do
      {
        username: username,
        password_digest: user.password_digest
      }.to_json
    end

    after { RedisInstance.instance.del(username) }

    it 'serializes the user into redis' do
      expect(subject).to be true
      expect(RedisInstance.instance.get(username)).to eq expected_serialization
    end

    context 'when validation fails' do
      let(:password_confirmation) { 'boop!' }

      it "doesn't save and returns false" do
        expect(RedisInstance.instance).not_to receive(:set)
        expect(subject).to be false
      end
    end
  end

  describe '#attributes' do
    subject { user.attributes }

    let(:expected_attributes) do
      {
        'username' => username,
        'password_digest' => user.password_digest
      }
    end

    it 'lists all the serializable keys in a hash' do
      expect(subject.keys).to match_array(%w[username password_digest])
      expect(user.serializable_hash).to eq expected_attributes
    end
  end

  describe '#attributes=' do
    let(:attributes) do
      {
        'username' => 'first',
        'password_digest' => 'second'
      }
    end

    it 'assigns all attributes' do
      new_user = described_class.new
      new_user.attributes = attributes
      expect(new_user.serializable_hash).to eq attributes
    end
  end
end
