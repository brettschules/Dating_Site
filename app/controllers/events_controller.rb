class EventsController < ApplicationController
  before_action :authenticate, except: [:index]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new

    if @event.save
      redirect_to event_path(@event), success: "Successfully created a new event, invite your matches!"
    else
      flash.now[:error] = "Something went wrong."
      render :new
    end
  end

  def edit
    find_event
    redirect_to root_path, error: "You must be an admin to edit an event." unless current_user.admin
  end

  def update
    if find_event.update(event_params)
      redirect_to event_path(find_event)
    else
      flash.now[:error] = "Invalid attributes"
      render :edit
    end
  end

  def destroy
    if current_user.admin
      Event.find(params[:id]).destroy
      redirect_to root_path, success: "Successfully destroyed an event"
    else
      redirect_to root_path, failure: "You must be an admin to delete an event."
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :location, :date, :category, :description)
    end

    def find_event
        @event = Event.find(params[:id])
    end


end
