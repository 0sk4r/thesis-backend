# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::CommentsController, type: :request do
  describe 'POST #create' do
    let!(:post1) { create(:post) }
    let!(:user) { create(:user, &:confirm) }

    context 'unlogged user' do
      it 'return unauthorized access' do
        post api_comments_path, params: { content: 'test', post_id: post1.id }
        expect(response.status).to eq(401)
      end
    end

    context 'logged user' do
      before do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        post api_comments_path, params: { content: 'Test', post_id: post1.id }, headers: auth_params
      end
      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'response with created post' do
        json_response = JSON.parse(response.body)
        expect(json_response['content']).to eq('Test')
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
