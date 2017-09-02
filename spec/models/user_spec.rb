require 'rails_helper'
require 'support/matchers/violate_check_constraint_matcher'

describe User, type: :model do
  describe '#new' do
    let(:user) do
      User.new(
        email: 'test@example.com',
        password: 'foooooooooword',
        password_confirmation: 'foooooooooword',
      )
    end

    it 'is valid with an email address and password' do
      expect(user).to be_valid
    end

    it 'is invalid without an email address' do
      user.update(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a password' do
      user.update(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email address' do
      user.save
      dup_user = User.new(
        email: 'test@example.com',
        password: 'foooooword',
        password_confirmation: 'foooooword',
      )
      dup_user.valid?
      expect(dup_user.errors[:email]).to include('has already been taken')
    end
  end
end
