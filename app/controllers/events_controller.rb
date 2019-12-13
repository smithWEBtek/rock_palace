class EventsController < ApplicationController

  before_action :authenticate, only: [ :new, :create, :edit, :update ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Successfully created event.'
      redirect_to event_path(@event)
    else
      flash[:notice] = 'Unable to create event due to errors. Please review.'
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = 'Successfully updated event.'
      redirect_to event_path(@event)
    else
      flash[:notice] = 'Unable to update event due to errors. Please review.'
      render :edit
    end
  end

  private

    def event_params
      params.require(:event).permit(:performer, :when, :content)
    end
end
