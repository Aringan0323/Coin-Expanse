class ApplicationController < ActionController::Base
#   before_action :authenticate_user!, :except => [:new]
  include SessionsHelper

  private

  def authenticate_user!
    redirect_to '/login' if !logged_in?
  end
end
