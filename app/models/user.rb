require 'digest'
class User < ApplicationRecord
  #has_many :portfolios

  # add a user password verification system

  include ActiveModel::SecurePassword
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
