class SessionsController < ApplicationController
  helper_method :create

  def new
    # regular login page for existing user
  end

  def create
    #post new session for existing user

    user = User.find_by(email: params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "You are now logged in."
    else
      flash.now[:error] = "You have entered invaild information."
      render :new
    end
  end

  def destroy
    #end session
    session.delete :user_id
    redirect_to root_path, notice: "You have logged out."
  end
end
