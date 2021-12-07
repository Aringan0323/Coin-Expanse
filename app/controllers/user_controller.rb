class UserController < PublicController
  include SessionsHelper

  def update
    require_login
    user = current_user
    if user.update(params.require(:user).permit(:full_name, :username, :encryptedBinanceApiKey, :binance_public_key, :email))
      flash[:success] = 'Successfully updated your account'
    else
      flash[:danger] = 'Unable to successfully update, please check to see if you misentered input, or contact an administrator'
    end
    redirect_to '/account'
  end

  def create
    user = User.new(params.require(:user).permit(:full_name, :username, :password, :password_confirmation, :encryptedBinanceApiKey, :binance_public_key, :email))
    if user.valid?
      user.userSince = DateTime.now
      user.save
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def new; end

  def show
    require_login
    @user = current_user
  end

  def edit
    require_login
  end

end
