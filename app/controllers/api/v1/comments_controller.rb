class Api::V1::CommentsController < Api::V1::BaseController
  before_filter :authenticate_user, except: [:index, :show]
  before_filter :authorize_user, except: [:index, :show]

  def index
    if params[:post_id]
      comments = post.comments
    else
    comments = Comment.all
  end
  
    render json: comments.to_json, status: 200
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment.to_json, status: 200
  end
end
