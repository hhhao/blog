class FavouritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favourite = Favourite.new(post: @post, user: current_user)
    respond_to do |format|
      if can?(:favourite, @post) && favourite.save
        format.js {render :create_success}
        format.html {redirect_to :back}
      else
        format.js {render :create_failure}
        format.html {redirect_to :back, favourite.errors.full_messages.join(', ')}
      end
    end
  end

  def destroy
    favourite = Favourite.find(params[:id])
    @post = favourite.post
    favourite.destroy
    respond_to do |format|
      format.js {render}
      format.html {redirect_to :back}
    end
  end
end
