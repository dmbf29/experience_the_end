class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  valdates :name, presence: true
  valdates :price, presence: true
end
