class AvatarsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.avatar.attach(params[:avatar])
  end
end
