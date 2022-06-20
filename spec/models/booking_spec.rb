require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe '#initialize' do
    context 'when valid' do
      it 'generates a valid experience with all columns' do
        booking = build(:booking)
        expect(booking.valid?).to eq(true)
      end
    end

    context 'when invalid' do
      it 'generates an invalid booking' do
        booking = build(:booking,
          participants: nil,
          date: nil,
          user: nil,
          experience: nil
        )
        expect(booking.valid?).to eq(false)
      end

      it 'generates an error message' do
        booking = build(:booking,
          participants: nil,
          date: nil,
          user: nil,
          experience: nil
        )
        booking.valid?
        expect(booking.errors.messages).to eq({
          participants: ["is not a number"],
          date: ["can't be blank"],
          experience: ["must exist"],
          user: ["must exist"]
        })
      end
    end
  end

  # describe '#duration' do
  #   it 'returns nil duration if an experience doesn\'t have a start_time' do
  #     experience = create(:experience, status: "building", start_time: nil, end_time: Time.parse('11:00am'))
  #     expect(experience.duration).to eq(nil)
  #   end

  #   it 'returns nil duration if an experience doesn\'t have an end_time' do
  #     experience = create(:experience, status: "building", start_time: Time.parse('9:00am'), end_time: nil)
  #     expect(experience.duration).to eq(nil)
  #   end

  #   it 'returns a float duration for valid times on an experience' do
  #     experience = create(:experience, start_time: Time.parse('9:00am'), end_time: Time.parse('11:00am'))
  #     expect(experience.duration).to eq(2.0)
  #   end
  # end
end
