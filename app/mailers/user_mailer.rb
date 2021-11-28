class UserMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Welcome to Coin Expanse!")
    end

    def forgot_password(user)
        @user = user
        mail(to: @user.email, subject: "Password Reset")
        
    end

end
