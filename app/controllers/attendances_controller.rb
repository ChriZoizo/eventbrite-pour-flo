class AttendancesController < ApplicationController
  def new
  end

  def index
    @event = Event.find(params[:event_id])
    @users = User.where(id: @event.user_ids)
  end

  def create
    Attendance.create(stripe_customer_id: "free", user_id: current_user.id, event_id: params[:event_id])
    redirect_to root_path
  end
end
