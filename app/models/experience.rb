class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  valdates :name, presence: true
  valdates :price, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # TODO: The seeds don't have proper addresses
end
