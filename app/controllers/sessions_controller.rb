class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    user.failed_attempts_count ||= 0 if user
    if user && user.failed_attempts_count >= 3
      redirect_to new_reset_password_path, alert: 'Account locked, please reset password'
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.failed_attempts_count = 0
      user.save
      redirect_to root_path, notice: 'You are signed in'
    else
      user.failed_attempts_count += 1
      user.save
      flash[:alert] = 'Wrong email/password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You are signed out'
  end
end
