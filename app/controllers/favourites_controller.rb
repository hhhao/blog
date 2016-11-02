class FavouritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favourite = Favourite.new(post: post, user: current_user)
    if can?(:favourite, post) && favourite.save
      redirect_to :back
    else
      redirect_to :back, favourite.errors.full_messages.join(', ')
    end
  end

  def destroy
    Favourite.find(params[:id]).destroy
    redirect_to :back
  end
end
