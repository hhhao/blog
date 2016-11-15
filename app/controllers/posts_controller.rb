class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  PER_PAGE = 7
  def index
    @query = params[:query]
    session[:query] = @query
    if !@query.nil?
      @posts = Post.where("title ilike ? or body ilike ?", "%#{@query}%", "%#{@query}%").page(params[:page]).per(PER_PAGE)
    else
      if params[:show_favs]
        @posts = current_user.fav_posts.page(params[:page]).per(PER_PAGE)
      else
        @posts = Post.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
      end
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
     params.require(:post).permit(:title, :body, :category_id)
  end

end
