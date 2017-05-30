class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  def new
    # get signup page
    @user = User.new
  end

  def create
    #post a new user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.now[:success] = "Successfully created a user"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Please complete all required items"
      render :new
    end
  end

  def edit
    find_user
  end

  def update
    find_user
  end

  def destroy
    find_user
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :height, :picture_url, :city, :birthday, :phone_number, :email, :password, :men, :women, :genderqueer)

    def find_user
      @user = User.find(params[:id])
    end
  end


end
