class FixDateIssuesOnBookings < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookings, :start_time, :datetime
    remove_column :bookings, :end_time, :datetime
    add_column :bookings, :date, :date
    add_column :bookings, :participants, :integer
    add_column :experiences, :start_time, :time
    add_column :experiences, :end_time, :time
  end
end
