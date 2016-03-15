require 'rails_helper'
include RandomData

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_user)      { create(:user) }
  let(:my_topic)     { create(:topic) }
  let(:my_post)      { create(:post, topic: my_topic, user: my_user) }

  context "unauthenticated user" do
    it "PUT #update returns http unauthenticated" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to have_http_status(401)
    end

    it "POST #create returns http unauthenticated" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      post :create, topic_id: my_topic.id, post: {title: new_title, body: new_body}
      expect(response).to have_http_status(401)
    end

    it "DELETE #destroy returne http unauthenticated" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(401)
    end
  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "PUT #update returns http forbidden" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to have_http_status(403)
    end

    it "POST #create returns http forbidden" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      post :create, topic_id: my_topic.id, post: {title: new_title, body: new_body}
      expect(response).to have_http_status(403)
    end

    it "DELETE #destroy returne http forbidden" do
      delete :destroy, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(403)
    end
  end

  context "authorized user" do
    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      @new_post = build(:post)
    end

    describe "PUT #update" do
      before { put :update, topic_id: my_topic.id, id: my_post.id, post: {title: @new_post.title, body: @new_post.body } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq('application/json')
      end

      it "updates post with correct attributes" do
        updated_post = Post.find(my_post.id)
        expect(updated_post.to_json).to eq(response.body)
      end
    end

    describe "POST #create" do
      before { post :create, topic_id: my_topic.id, post: {title: @new_post.title, body: @new_post.body} }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq('application/json')
      end

      it "creates post with correct attributes" do
        hashed_json = JSON.parse(response.body)
        expect(@new_post.title).to eq(hashed_json["title"])
        expect(@new_post.body).to eq(hashed_json["body"])
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, topic_id: my_topic.id, id: my_post.id }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json content type" do
        expect(response.content_type).to eq('application/json')
      end

      it "returns correct json success message" do
        expect(response.body).to eq({"message" => "Post destroyed","status" => 200}.to_json)
      end

      it "deletes the post" do
        expect(my_topic.posts.where(id: my_post.id).first).to be_nil
      end
    end
  end
end
