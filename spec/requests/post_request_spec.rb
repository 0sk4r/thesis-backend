# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PostsController, type: :request do
  describe 'GET #index' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }
    before { get api_posts_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'response with json' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'should return array of posts' do
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
    end
  end

  describe 'GET #show/:id' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }
    let!(:current_user) { create(:user) }
    before { get api_post_path post1.id }

    it 'returns http success' do
      expect(response).to have_http_status(:success)

      expect(response.content_type).to eq 'application/json'
    end

    it 'response with post data' do
      json_response = JSON.parse(response.body)

      expect(json_response['id']).to eq(post1.id)
      expect(json_response['content']).to eq(post1.content)
    end
  end
  describe 'POST #create' do
    let!(:user) { create(:user, &:confirm) }
    let!(:category) { create(:category) }

    context 'unlogged user' do
      it 'return unauthorized access' do
        post api_posts_path
        expect(response.status).to eq(401)
      end
    end

    context 'logged user' do
      before do
        login
        auth_params = get_auth_params_from_login_response_headers(response)
        post api_posts_path, params: { title: 'Test', content: 'Test test', category_id: category.id }, headers: auth_params
      end
      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'response with created post' do
        json_response = JSON.parse(response.body)
        expect(json_response['post']['title']).to eq('Test')
        expect(json_response['post']['content']).to eq('Test test')
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
