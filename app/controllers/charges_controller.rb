class ChargesController < ApplicationController
  def new
    @event = Event.find_by(id: params[:event_id])
    attendance = Attendance.find_by(user_id: current_user.id, event_id: @event.id)
    if attendance
      flash[:alert] = "Vous avez déjà souscris une participation à l'évènement !"
      redirect_to event_path(@event.id)
    end
  end

  def create
    # Amount in cents
    @event = Event.find_by(id: params[:event_id])
    if is_free?(@event)
      Attendance.create(user_id: current_user.id, event_id: @event.id)
      redirect_to event_path(@event.id)
    else
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @event.price.to_i * 100,
        description: "Inscription de #{current_user.email}",
        currency: "eur",
      })
    end

    if customer.save && charge.save
      Attendance.create(user_id: current_user.id, event_id: @event.id, stripe_customer_id: customer.id)
      redirect_to event_path(@event.id)
    else
      render "new"
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
