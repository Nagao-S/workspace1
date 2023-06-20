# HTTPステータスが200であること
# ユーザ属性が正しいこと
require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/users' do
    let(:user_params) do
      attributes_for(:user)
    end

    it 'creates a new user' do
      expect do
        post api_users_path, params: { user: user_params }, as: :json
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(200)
      expect(json['user']).to include(
        'username' => user_params[:username],
        'email' => user_params[:email],
        'bio' => user_params[:bio],
        'image' => user_params[:image]
      )
      expect(json['user']).to have_key('token')
    end
  end
end
