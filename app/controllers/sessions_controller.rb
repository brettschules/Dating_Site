class SessionsController < ApplicationController

  def new
    # regular login page for existing user
  end

  def create
    #post new session for existing user

    user = User.find_by(email: params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to root_path
    end
  end

  def destroy
    #end session
    session.delete :user_id
    redirect_to root_path
  end
end
