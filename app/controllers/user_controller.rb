class UserController < ApplicationController
  def create
    @user = User.new(params.require(:user).permit(:name, :password, :password_confirmation))
  end
end
