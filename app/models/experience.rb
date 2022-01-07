class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  validates :name, presence: true
  validates :price, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true\
  validates :photos, limit: { min: 2, max: 4 }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # TODO: The seeds don't have proper addresses

  def start_time_formatted
    start_time.strftime('%l%p')
  end

  def end_time_formatted
    end_time.strftime('%l%p')
  end
end
