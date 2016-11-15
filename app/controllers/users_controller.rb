class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thanks for signing up'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.update params.require(:user).permit(:first_name, :last_name, :email )
    if params[:user][:current_password] != ''
      if @user.authenticate(params[:user][:current_password]) || params[:user][:current_password] == @user.password_digest
        if params[:user][:current_password] != params[:user][:password]
          @user.update params.require(:user).permit(:password, :password_confirmation)
          if @user.save
            redirect_to root_path, notice: 'User pass edit successful'
          else
            flash.now[:alert] = 'Could not pass edit user info'
            render :edit
          end
        else
          flash.now[:alert] = 'New password must be different'
          render :edit
        end
      else
        flash.now[:alert] = 'Wrong password'
        render :edit
      end
    else
      if @user.save
        redirect_to root_path, notice: 'User edit successful'
      else
        flash.now[:alert] = 'Could not edit user info'
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
                                               :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find params[:id]
  end
end
