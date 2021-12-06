require 'digest'
class User < ApplicationRecord
  #has_many :portfolios

  # add a user password verification system

  include ActiveModel::SecurePassword
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :strategies
  has_many :orders
  
  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    email = UserMailer.forgot_password(self)# This sends an e-mail with a link for the user to reset the password
    email.deliver
  end

  private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
