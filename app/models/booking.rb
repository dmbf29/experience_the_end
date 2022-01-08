class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience
  validates :date, presence: true
  validates :participants, numericality: { only_integer: true, greater_than: 0 }
  enum status: { pending: 0, accepted: 1, rejected: 2 }

  scope :past, -> { where('date < ?', Date.today) }
  scope :future, -> { where('date > ?', Date.today) }
  scope :today, -> { accepted.where(date: Date.today) }
  scope :upcoming, -> { accepted.future }
  scope :need_response, -> { pending.future }
  scope :expired, -> { pending.past }
  scope :completed, -> { accepted.past }
  scope :not_rejected, -> { where.not(status: :rejected) }

  def price
    experience.price * participants
  end
end
