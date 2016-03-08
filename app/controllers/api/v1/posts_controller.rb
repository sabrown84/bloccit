class Api::V1::PostsController < Api::V1::BaseController
  before_filter :authenticate_user, except: [:index, :show]
  before_filter :authorize_user, except: [:index, :show]

  def index
    if params[:topic_id]
      topic = Topic.find(params[:topic_id])
      posts = topic.posts
    else
      posts = Post.all
    end
    
    render json: posts.to_json, status: 200
  end

  def show
    post = Post.find(params[:id])
    render json: post.to_json(include: :comments), status: 200
  end
end
