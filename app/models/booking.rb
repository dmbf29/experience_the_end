class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  valdates :start_time, presence: true
  valdates :end_time, presence: true
  enum status: { pending: 0, accepted: 1, rejected: 2 }
end
