class EventUsersController < ApplicationController
  before_action :authenticate

  def create
    @event = Event.find(params[:event_id].to_i)
    @user = current_user
    @event_user = EventUser.new(user_id: @user.id, event_id: @event.id)

    #fix needed
    #if @event_users.user_id == current_user.id
    # EventUser.where(user_id: current_user, event_id: @event.id)
    # this is not working bc it's has to be saved in DB first?

    if @event_user.save
      flash[:notice] = "Looking forward to seeing you there!"
    else
      flash[:error] = "You cannot attend the same event twice"
    end
    redirect_to event_path(@event)

  end


end
