class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  HOURS = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5]
  validates :name, presence: true
  validates :price, presence: true
  validates :hours, inclusion: { in: HOURS }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # TODO: The seeds don't have proper addresses
end
