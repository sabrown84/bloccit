require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:my_user)     { create(:user) }
  let(:other_user)  { create(:user) }
  let(:my_topic)    { create(:topic) }
  let(:my_post)     { create(:post, topic: my_topic, user: my_user) }
  let(:my_comment)  { create(:comment, post: my_post, user: other_user) }

  context "unauthenticated user" do
    it "GET #index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET #show returns http success" do
      get :index, post_id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "GET #index returns http success with post id" do
        get :index, post_id: my_post.id
        expect(response).to have_http_status(:success)
      end
    end

  context "authorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET #index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET #index returns http success with post id" do
      get :index, post_id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "GET #show returns http success" do
      get :show, post_id: my_post.id, id: my_comment.id
      expect(response).to have_http_status(:success)
    end
  end
end
