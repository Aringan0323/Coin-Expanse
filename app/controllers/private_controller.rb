class PrivateController < ApplicationController
  include SessionsHelper
  before_action :require_login

  private

  def require_login
    unless logged_in?
      redirect_to :root
    end
  end
end