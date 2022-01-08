class AddDefaultValueToStatusInBookings < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :status, :integer, default: 0
  end
end
