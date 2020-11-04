class ChargesController < ApplicationController
  def new
    @event = Event.find(params[:id])
  end

  def create
    # Amount in cents
    @event = Event.find(params[:id])

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @event.price.to_i * 100,
      description: "Rails Stripe customer",
      currency: "usd",
    })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
