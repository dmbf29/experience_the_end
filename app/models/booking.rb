class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  validates :date, presence: true
  validates :participants, numericality: { only_integer: true, greater_than: 0 }
  enum status: { pending: 0, accepted: 1, rejected: 2 }
end
