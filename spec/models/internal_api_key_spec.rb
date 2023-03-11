# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternalAPIKey do
  describe '.find_by' do
    subject { described_class.find_by(args) }

    it 'can find by id' do
      # expect(described_class.find_by(id: 1)).to be_an_instance_of(described_class)
      # expect(described_class.find_by(id: 2)).to be_an_instance_of(described_class)
      expect(described_class.find_by(id: 3)).to be nil
    end

    it 'can find by key' do
      expect(described_class.find_by(value: 'valid-key')).to be_an_instance_of(described_class)
      expect(described_class.find_by(value: 'expired-key')).to be_an_instance_of(described_class)
      expect(described_class.find_by(value: 'invalid-key')).to be nil
    end

    it 'can find by multiple attributes' do
      expect(described_class.find_by(value: 'valid-key', id: 1)).to be_an_instance_of(described_class)
      expect(described_class.find_by(value: 'valid-key', id: 2)).to be nil
      expect(described_class.find_by(value: 'expired-key', id: 1)).to be nil
      expect(described_class.find_by(value: 'expired-key', id: 2)).to be_an_instance_of(described_class)
    end
  end

  describe '#active?' do
    subject { key.active? }

    context 'when expires_at is nil' do
      let(:key) { described_class.new(id: 1, value: 'abc', expires_at: nil) }

      it { is_expected.to be true }
    end

    context 'when expires_at is in the future' do
      let(:key) { described_class.new(id: 1, value: 'abc', expires_at: 10.minutes.from_now) }

      it { is_expected.to be true }
    end

    context 'when expires_at is in the past' do
      let(:key) { described_class.new(id: 1, value: 'abc', expires_at: 10.minutes.ago) }

      it { is_expected.to be false }
    end
  end
end
