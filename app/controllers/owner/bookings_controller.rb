module Owner
  class BookingsController < ApplicationController
    def index
      @bookings = policy_scope([:owner, Booking]).order(date: :asc)
    end
  end
end
