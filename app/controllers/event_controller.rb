class EventController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :new, :update, :destroy, :edit]

  def index
    @event = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    post_params = params.require(:event).permit(:title, :start_date, :duration, :description, :price, :location)
    @event.update(post_params)
  end

  def new
    @new_event = Event.new
  end

  def create
    @new_event = Event.create("start_date" => params[:start_date],
                              "duration" => params[:duration],
                              "title" => params[:title],
                              "description" => params[:description],
                              "location" => params[:location],
                              "price" => params[:price],
                              "organizer_id" => current_user.id)

    if @new_event.save
      redirect_to edit_event_path(@new_event.id)
    end
  end

  def show
    @event = Event.find(params[:id])
    @end_date = @event.start_date + (@event.duration * 60)
    @attendance = Attendance.where(user_id: current_user.id, event_id: @event.id).exists?
    @users = User.where(id: @event.user_ids)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private
end
