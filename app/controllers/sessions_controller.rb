class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
