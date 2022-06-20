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

  describe '#price' do
    it 'returns an Integer ' do
      booking = build(:booking, participants: 2)
      expect(booking.price).to be_an(Integer)
    end

    it 'returns the experience price for 1 participant' do
      booking = build(:booking, participants: 1)
      expect(booking.price).to eq(500)
    end

    it 'returns the total experience price for 2 participant' do
      booking = build(:booking, participants: 2)
      expect(booking.price).to eq(1000)
    end
  end
end
