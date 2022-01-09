class Experience < ApplicationRecord
  belongs_to :user
  has_many_attached :photos # Should 2-4 photos
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, if: :active_or_name?
  validates :start_time, presence: true, if: :active_or_start?
  validates :end_time, presence: true, if: :active_or_end?
  validates :price, presence: true, if: :active_or_price?
  validates :description, presence: true, if: :active_or_description?
  validates :address, presence: true, if: :active_or_address?
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # TODO: The seeds don't have proper addresses
  enum status: { building: 'building', active: 'active' }

  def duration
    return nil unless end_time && start_time

    (end_time - start_time) / 1.hour
  end

  def start_time_formatted
    start_time.strftime('%l%p')
  end

  def end_time_formatted
    end_time.strftime('%l%p')
  end

  def active_or_name?
    status.include?('name') || active?
  end

  def active_or_start?
    status.include?('start') || active?
  end

  def active_or_end?
    status.include?('end') || active?
  end

  def active_or_description?
    status.include?('description') || active?
  end

  def active_or_price?
    status.include?('price') || active?
  end

  def active_or_address?
    status.include?('address') || active?
  end
end
