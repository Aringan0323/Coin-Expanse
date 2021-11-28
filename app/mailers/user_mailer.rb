class UserMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Welcome to Coin Expanse!")
    end

    def password_reset(email)
        @user = user.
        
    end

end
