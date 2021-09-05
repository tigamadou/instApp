class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # If login is successful
    else
      flash.now[:danger] = 'I failed to login'
      render :new
    end
  end
end
