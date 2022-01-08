class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings # bookings as a client
  has_many :experiences, dependent: :destroy
  has_many :bookings_as_owner, through: :experiences, source: :bookings
  has_many :reviews_as_owner, through: :experiences, source: :reviews
  has_one_attached :photo

  def owner_rating
    reviews_as_owner.average(:rating).round(2)
  end

  def owner_rate_5_stars
    (reviews_as_owner.where(rating: 5).size.to_f / reviews_as_owner.size * 100).round
  end

  def owner_response_rate
    ((1 - bookings_as_owner.expired.count.to_f / bookings_as_owner.count) * 100).round
  end

  def owner_earnings
    bookings_as_owner.sum('experiences.price * participants')
  end
end
