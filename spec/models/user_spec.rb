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
      context 'without email and password' do
        it 'generates an invalid user' do
          user = build(:user, email: nil, password: nil)
          expect(user.valid?).to eq(false)
        end

        it 'generates an error message' do
          user = build(:user, email: nil, password: nil)
          user.valid?
          expect(user.errors.messages).to eq({ email: ["can't be blank"], password: ["can't be blank"] })
        end
      end
    end
  end

  # describe '#truncated_details' do
  #   it 'returns truncated details' do
  #     expect(user.truncated_details).to eq('Once upon a...')
  #   end
  # end
end
