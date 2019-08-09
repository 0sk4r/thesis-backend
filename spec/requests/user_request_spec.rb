# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  describe 'GET #my_info' do
    let!(:user) { create(:user, &:confirm) }

    context 'unlogged user' do
      it 'return unauthorized access' do
        get api_users_getInfo_path
        expect(response.status).to eq(401)
      end
    end

    context 'logged user' do
      before do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        get api_users_getInfo_path, headers: auth_params
      end
      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'response with created post' do
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eq(user.name)
        expect(json_response['nickname']).to eq(user.nickname)
        expect(json_response['id']).to eq(user.id)
      end
    end
  end

  describe 'GET #find' do
    let!(:user1) { create(:user, nickname: 'abc') }
    let!(:user2) { create(:user, nickname: 'aac') }
    let!(:user3) { create(:user, nickname: 'bcc') }

    context 'should response with two users' do
      before do
        get api_users_find_path, params: { key: 'a' }
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'response 2 users' do
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(2)
      end
    end

    context 'should response with two users' do
      before do
        get api_users_find_path, params: { key: 'aa' }
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'response 2 users' do
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(1)
      end

      it 'response correct user' do
        json_response = JSON.parse(response.body)
        expect(json_response[0]['nickname']).to eq(user2.nickname)
      end
    end
  end
end

def login
  post new_user_session_path, params: { "email": user.email, "password": user.password }
end

def get_auth_params_from_login_response_headers(response)
  client = response.headers['client']
  token = response.headers['access-token']
  expiry = response.headers['expiry']
  token_type = response.headers['token-type']
  uid = response.headers['uid']

  auth_params = {
    'access-token' => token,
    'client' => client,
    'uid' => uid,
    'expiry' => expiry,
    'token_type' => token_type
  }
  auth_params
end
