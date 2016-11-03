class ResetPasswordsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    @token = Digest::SHA256.hexdigest(rand(100000).to_s)
    @user.reset_password_digest = @token
    @user.reset_sent_at = DateTime.now
    if @user.save
      render :new
    else
      redirect_to new_reset_password_path, alert: 'No such email'
    end
  end

  def edit
    @user = User.find_by(reset_password_digest: params[:id])
  end

  def update
    @user = User.find params[:id]
    if @user.reset_sent_at >= DateTime.now - 1.day
      if @user.update params.permit(:password, :password_confirmation)
        user.failed_attempts_count = 0
        redirect_to new_session_path, notice: 'Password reset, please sign in'
      else
        flash.now[:alert] = 'Passwords do not match'
        render :edit
      end
    else
      redirect_to new_session_path, alert: 'Reset expired'
    end
  end
end
