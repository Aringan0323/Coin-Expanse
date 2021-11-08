class PrivateController < ApplicationController
  include SessionsHelper
  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:danger] = "You must be logged in to access this page"
      redirect_to '/login'
    end
  end
end