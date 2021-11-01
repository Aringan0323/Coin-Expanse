class ApplicationController < ActionController::Base
#   before_action :authenticate_user!, :except => [:new]
  include SessionsHelper
end
