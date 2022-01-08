class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  validates :date, presence: true
  validates :participants, numericality: { only_integer: true, greater_than: 0 }
  enum status: { pending: 0, accepted: 1, rejected: 2 }

  scope :expired, -> { pending.where('date < ?', Date.today) }
  scope :need_response, -> { pending.where('date >= ?', Date.today) }
  scope :today, -> { accepted.where(date: Date.today) }
  scope :upcoming, -> { accepted.where('date > ?', Date.today) }
  scope :past, -> { where('date < ?', Date.today) }

  def price
    experience.price * participants
  end
end
