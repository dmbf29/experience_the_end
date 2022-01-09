class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end

  def create
    @experience = Experience.find(params[:experience_id])
    @booking = Booking.new(booking_params)
    @booking.experience = @experience
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render 'experiences/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :participants, :status)
  end
end
