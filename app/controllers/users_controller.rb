class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  def index
    @users = User.all
  end
  def new
    # get signup page
    @user = User.new
  end

  def create
    #post a new user
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), success: "Successfully created a user"
    else
      flash.now[:error] = "Please complete all required (*) items"
      render :new
    end
  end

  def show
    find_user
  end

  def edit
    find_user
    redirect_to root_path unless current_user.admin || current_user.id == @user.id
  end

  def update
    find_user
  end

  def destroy
    find_user
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :mgender, :fgender, :qgender, :height, :picture_url, :city, :birthday, :phone_number, :email, :password, :men, :women, :genderqueer)
  end

  def find_user
      @user = User.find(params[:id])
  end


end
