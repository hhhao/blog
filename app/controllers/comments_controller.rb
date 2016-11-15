class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def new
  end

  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.js {render :create_success}
        format.html {redirect_to post_path(@post)}
      else
        format.js {render :create_failure}
        format.html {render 'posts/show'}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

  def find_post
    @post = Post.find params[:post_id]
  end

  def find_comment
    @comment = Comment.find params[:id]
  end
end
