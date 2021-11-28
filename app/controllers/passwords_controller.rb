class PasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      flash[:notice] = 'E-mail sent with password reset instructions.'
    else
      flash[:notice] = 'Account does not exist with that email'
    end
    redirect_to "/login"
  end

  def edit
    user = User.find_by_reset_password_token(params[:id])
    if user
      @user = user
    else
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_path
    end
  end

  def update
    @user = User.find_by_reset_password_token!(params[:id])
    if @user.reset_password_sent_at < 2.hour.ago
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_path
    elsif @user.update(user_params)
      flash[:notice] = 'Password has been reset!'
      redirect_to "/login"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password)
  end

end
