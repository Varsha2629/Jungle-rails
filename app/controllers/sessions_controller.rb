class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    # If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id in the browser cookie. 
      session[:user_id] = user.id
      redirect_to :root
    else
       # failure, render login form
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end