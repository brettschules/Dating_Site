class EventsController < ApplicationController
  before_action :authenticate, except: [:index]

  def index
    @events = Event.all.order(:date)
  end

  def index_name
    @events = Event.all.order(:name, :date)
  end

  def index_category
    @events = Event.all.order(:category, :date)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user
    if @event.save
      redirect_to event_path(@event), success: "Successfully created a new event, invite your matches!"
    else
      flash.now[:error] = "Something went wrong."
      render :new
    end
  end

  def show
    find_event
    @eventuser = EventUser.new
  end

  def edit
    find_event
    redirect_to root_path, failure: "You must be an admin to edit an event." unless current_user.admin || @event.host_id == current_user.id
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
    @event = Event.find(params[:id])
    if current_user.admin || @event.host_id == current_user.id
      Event.find(params[:id]).destroy
      redirect_to events_path, success: "Successfully destroyed an event"
    else
      redirect_to root_path, failure: "You must be an admin to delete an event."
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :location, :date, :category, :description, :image_url)
    end

    def find_event
        @event = Event.find(params[:id])
    end


end
