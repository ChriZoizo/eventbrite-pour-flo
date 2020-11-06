class Admin::EventController < ApplicationController
  before_action :check_if_admin

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @end_date = @event.start_date + (@event.duration * 60)
    @users = User.where(id: @event.user_ids)
  end

  def new
  end

  def create
  end

  def edit
    @event_edit = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    # post_params = params.require(:event).permit(:title, :description, :start_date, :price, :duration, :location)
    @event.update(validated: true)
  end

  def destroy
    @event = Event.find(params[:id])
    redirect_to admin_event_index_path
    @event.destroy
  end

  private

  def check_if_admin
    unless current_user.is_admin?
      return true
    end
  end

  def validated
    @event = Event.find(params[:id])
    post_params = params.require(:event).permit(validated: true)
    @event.update(validated = true)
    redirect_to root_path
  end

  def unvalidate
    @event = Event.find(params[:id])
    @event.update(validated: false)
  end
end
