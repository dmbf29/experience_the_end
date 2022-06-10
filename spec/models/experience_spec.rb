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
      context 'without email and password' do
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

  # describe '#owner?' do
  #   it 'returns true if a experience has created one experience' do
  #   experience = create(:experience, email: 'testexperience1@example.com')
  #   experience.experiences.create(attributes_for(:experience))
  #     expect(experience.owner?).to eq(true)
  #   end

  #   it 'returns true if a experience has created more than one experience' do
  #     experience = create(:experience, email: 'testexperience2@example.com')
  #     experience.experiences.create(attributes_for(:experience, name: 'Ueno walk'))
  #     experience.experiences.create(attributes_for(:experience, name: 'Shinjuku walk'))
  #     expect(experience.owner?).to eq(true)
  #   end

  #   it 'returns false if a experience has not created any experiences' do
  #     experience = create(:experience, email: 'testexperience3@example.com')
  #     expect(experience.owner?).to eq(false)
  #   end
  # end
end
