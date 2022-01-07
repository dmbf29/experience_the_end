class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  validates :date, presence: true
  validates :participants, length: { minimum: 1 }, allow_blank: false
  enum status: { pending: 0, accepted: 1, rejected: 2 }
end
