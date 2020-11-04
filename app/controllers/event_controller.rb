class EventController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @event = Event.all
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
      redirect_to event_path(@new_event.id)
    end
  end

  def subscribe
    @event = Event.find(params[:id])
    if @event.attendances.include? current_user
      flash[:error] = "Tu participe deja a cet evenement"
    else
    end
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @event.price.to_i * 100,
      description: "Rails Stripe customer",
      currency: "eur",
    })

    @new_attendance = Attendance.create("user_id" => current_user.id,
                                        "event_id" => Event.find(params[:id]).id)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def show
    @event = Event.find(params[:id])
    @end_date = @event.start_date + (@event.duration * 60)
    @users = User.where(id: @event.user_ids)
  end

  def registered_users
  end
end
