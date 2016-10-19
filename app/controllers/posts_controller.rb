class PostsController < ApplicationController
  def index
    @page = 1
    @max_page = (Post.count / 10.0).ceil
    @posts = Post.order(created_at: :desc).limit(10)
  end

  def page
    @page = params[:page].to_i
    @max_page = (Post.count / 10.0).ceil
    @posts = Post.order(created_at: :desc).limit(10).offset((@page-1) * 10)
    render :index
  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render new_post_path
    end
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.find params[:id]
    if @post.update post_params
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    redirect_to posts_path
  end

  def search
    redirect_to show_search_path({query: params[:search]})
  end

  def show_search
    @query = params[:query]
    @posts = Post.where("title ilike ? or body ilike ?", "%#{@query}%", "%#{@query}%")
  end
end
