class RemoveEndTimeFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookings, :end_time, :datetime
    add_column :experiences, :hours, :float
  end
end
