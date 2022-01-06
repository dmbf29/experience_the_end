class DeleteEndDateFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookings, :end_time
  end
end
