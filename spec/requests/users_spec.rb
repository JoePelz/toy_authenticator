# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  def with_temporary_user(username, password)
    user = User.new(
      username: username,
      password: password,
      password_confirmation: password
    )
    user.save
    yield
    RedisInstance.instance.del(username)
  end

  describe 'POST /users/authenticate' do
    subject { post(path, params: params, headers: headers) }

    let(:path) { '/users/authenticate' }
    let(:username) { 'test_user' }
    let(:real_password) { 'h2f8057hro' }
    let(:password) { real_password }
    let(:params) do
      {
        "username": username,
        "password": password
      }
    end

    context 'with valid credentials' do
      let(:expected_response) do
        {
          'username' => username
        }
      end

      around do |example|
        with_temporary_user(username, real_password) do
          example.run
        end
      end

      it 'returns the user and a 200 status' do
        expect(subject).to eq 200
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'with invalid password' do
      let(:password) { 'incorrect' }
      let(:expected_response) do
        {
          'errors' => [
            {
              'detail' => 'Credentials are not valid',
              'status' => 401,
              'title' => 'Unauthorized'
            }
          ]
        }
      end

      around do |example|
        with_temporary_user(username, real_password) do
          example.run
        end
      end

      it 'returns a 401 status and an error message' do
        expect(subject).to eq 401
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'when no user exists' do
      let(:expected_response) do
        {
          'errors' => [
            {
              'detail' => 'Credentials are not valid',
              'status' => 401,
              'title' => 'Unauthorized'
            }
          ]
        }
      end

      it 'returns a 401 status and an error message' do
        expect(subject).to eq 401
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end
  end
end
