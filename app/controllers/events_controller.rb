class EventsController < ApplicationController
  before_action :authenticate, only: [ :new, :create, :edit, :update ]
  require 'will_paginate/array'

  def index
    if params[:oldest]
      @events = Event.oldest_first.paginate(:page => params[:page], :per_page => 5)
    elsif params[:all]
      @events = Event.all.order(:performer)
    else
      @events = Event.newest_first.merge(Event.future).paginate(:page => params[:page], :per_page => 5)
    end
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
      flash[:status] = 'success'
      redirect_to event_path(@event)
    else
      flash[:notice] = "Unable to create event due to errors. Please review." + "\n #{@event.errors.full_messages}"
      flash[:status] = 'alert'
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
      flash[:status] = 'success'
      redirect_to event_path(@event)
    else
      flash[:notice] = "Unable to update event due to errors. Please review." + "\n #{@event.errors.full_messages}"
      flash[:status] = 'alert'
      render :edit
    end
  end

  private

    def event_params
      params.require(:event).permit(:performer, :when, :content)
    end
end
