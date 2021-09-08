include Rails.application.routes.url_helpers
class UserMailer < ApplicationMailer
    
    def user_mail(user,post)
        @user = user
        @post = post
        mail to: "your email address", subject: "Inquiry confirmation email"
      end
end
