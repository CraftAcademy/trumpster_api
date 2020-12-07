class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    payment_status = perform_payment
    if payment_status
      current_user.update_attribute(:subscriber, true)
      render json: { message: "HUUUUUGGGEEEE Thanks for your money, now you are a REAL Trumpscriber!!", paid: true }
    else
      render json: { message: "Your payment information is RIGGED!!" }, status: 422
    end
  end

  private

  def perform_payment
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken],
      description: "For subscription to awesome website",
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 300,
      currency: "sek",
    )
    charge.paid
  end
end
