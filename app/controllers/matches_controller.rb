class MatchesController < ApplicationController

  def new
  end

  def  create

    @user_i_am = current_user
    @user_i_like = User.find(params[:likes_id].to_i)

    if @user_i_am == @user_i_like
      flash[:error] = "You can't like yourself"
      redirect_to user_path(@user_i_like)
      return
    end

    @match = Match.new(liked_id: @user_i_am.id, likes_id: @user_i_like.id)

    if @match.save
      flash[:notice] = "You just liked #{@user_i_like}"
      redirect_to user_path(@user_i_like)
    else
      flash[:error] = "You cannot like a person you already liked"
      redirect_to user_path(@user_i_like)
    end

  end

  def destroy
    @user_i_am = current_user
    @user_i_like = User.find(params[:id])
    @match = Match.where(liked_id: @user_i_am, likes_id: @user_i_like )
    if @match
      Match.destroy(Match.where(liked_id: @user_i_am, likes_id: @user_i_like ).ids[0])
      flash[:notice] = "You just unliked #{@user_i_like}"
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to user_path(@user_i_like)
  end


end
