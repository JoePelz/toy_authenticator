# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  describe 'POST /admin/users' do
    subject { post(path, params: params, headers: headers) }

    let(:path) { '/admin/users' }
    let(:username) { 'test_user' }
    let(:params) do
      {
        "username": username,
        "password": 'h2f8057hro',
        "password_confirmation": 'h2f8057hro'
      }
    end
    let(:headers) do
      { 'X-API-Key' => 'valid-key' }
    end

    context 'with a valid request' do
      let(:expected_response) do
        {
          'username' => username
        }
      end

      after { RedisInstance.instance.del(username) }

      it 'returns the user and a 201 status' do
        expect(subject).to eq 201
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'with an invalid request' do
      let(:params) do
        {
          "username": username,
          "password": 'h2f8057hro',
          "password_confirmation": 'mismatched'
        }
      end
      let(:expected_response) do
        {
          'errors' => [
            {
              'detail' => "Password confirmation doesn't match Password",
              'status' => 422,
              'title' => 'Unprocessable Content'
            }
          ]
        }
      end

      it 'returns a 422 status and an error message' do
        expect(subject).to eq 422
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'with an unauthenticated request' do
      let(:headers) do
        { 'X-API-Key' => 'expired-key' }
      end
      let(:expected_response) do
        {
          'errors' => [
            {
              'detail' => 'API key is invalid',
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
