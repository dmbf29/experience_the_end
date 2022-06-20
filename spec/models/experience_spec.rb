require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe '#initialize' do
    context 'when valid' do
      it 'generates a valid experience with all columns' do
        experience = build(:experience)
        expect(experience.valid?).to eq(true)
      end
    end

    context 'when invalid' do
      context 'while being active' do
        it 'generates an invalid experience' do
          experience = build(:experience,
            status: 'active',
            name: nil,
            start_time: nil,
            end_time: nil,
            price: nil,
            description: nil,
            address: nil
          )
          expect(experience.valid?).to eq(false)
        end

        it 'generates an error message' do
          experience = build(:experience,
            status: 'active',
            name: nil,
            start_time: nil,
            end_time: nil,
            price: nil,
            description: nil,
            address: nil
          )
          experience.valid?
          expect(experience.errors.messages).to eq({
            name: ["can't be blank"],
            start_time: ["can't be blank"],
            end_time: ["can't be blank"],
            price: ["can't be blank"],
            description: ["can't be blank"],
            address: ["can't be blank"]
          })
        end
      end
    end
  end

  describe '#duration' do
    it 'returns nil duration if an experience doesn\'t have a start_time' do
      experience = create(:experience, status: "building", start_time: nil, end_time: Time.parse('11:00am'))
      expect(experience.duration).to eq(nil)
    end

    it 'returns nil duration if an experience doesn\'t have an end_time' do
      experience = create(:experience, status: "building", start_time: Time.parse('9:00am'), end_time: nil)
      expect(experience.duration).to eq(nil)
    end

    it 'returns a float duration for valid times on an experience' do
      experience = create(:experience, start_time: Time.parse('9:00am'), end_time: Time.parse('11:00am'))
      expect(experience.duration).to eq(2.0)
    end
  end
end
