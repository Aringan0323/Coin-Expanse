class UserController < ApplicationController
  include SessionsHelper
  def create
    user = User.new(params.require(:user).permit(:username, :password, :password_confirmation, :encryptedBinanceApiKey, :email))
    if user.valid?
      user.save
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def new; end
end
