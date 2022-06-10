require 'rails_helper'

RSpec.describe User, type: :model do
  user = build(:user)

  describe '#initialize' do
    context 'when valid' do
      it 'generates a valid user with all columns' do
        expect(user.valid?).to eq(true)
      end
    end

    context 'when invalid' do
      context 'without email' do
        before do
          user.email = nil
          user.password = nil
        end

        it 'generates an invalid user' do
          expect(user.valid?).to eq(false)
        end

        it 'generates an error message' do
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
