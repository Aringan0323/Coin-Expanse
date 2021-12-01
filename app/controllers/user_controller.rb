class UserController < PublicController
  include SessionsHelper
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
  end

end
