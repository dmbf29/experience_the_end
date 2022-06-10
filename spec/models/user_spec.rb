require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#initialize' do
    context 'when valid' do
      it 'generates a valid user with all columns' do
        user = build(:user)
        expect(user.valid?).to eq(true)
      end
    end

    context 'when invalid' do
      context 'without proper attributes' do
        it 'generates an invalid user' do
          user = build(:user, email: nil, password: nil)
          expect(user.valid?).to eq(false)
        end

        it 'generates an error message' do
          user = build(:user, email: nil, password: nil)
          user.valid?
          expect(user.errors.messages).to eq({
              email: ["can't be blank"],
              password: ["can't be blank"]
            })
        end
      end
    end
  end

  describe '#owner?' do
    it 'returns true if a user has created one experience' do
    user = create(:user, email: 'testuser1@example.com')
    user.experiences.create(attributes_for(:experience))
      expect(user.owner?).to eq(true)
    end

    it 'returns true if a user has created more than one experience' do
      user = create(:user, email: 'testuser2@example.com')
      user.experiences.create(attributes_for(:experience, name: 'Ueno walk'))
      user.experiences.create(attributes_for(:experience, name: 'Shinjuku walk'))
      expect(user.owner?).to eq(true)
    end

    it 'returns false if a user has not created any experiences' do
      user = create(:user, email: 'testuser3@example.com')
      expect(user.owner?).to eq(false)
    end
  end
end
