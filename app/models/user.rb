class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings # bookings as a client
  has_many :experiences
  has_many :bookings_as_owner, through: :experiences, source: :bookings
  has_one_attached :photo
end
