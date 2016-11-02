class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def new
  end

  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
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
