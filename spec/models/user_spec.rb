require 'rails_helper'
require 'support/matchers/violate_check_constraint_matcher'

describe User, :type => :model do
  describe "email" do
    let(:user) {
      User.create!(
        email: "foo@example.com",
        password: "qwertyuiop",
        password_confirmation: "qwertyuiop",
      )
    }

    it "absolutely prevents invalid email addresses" do
      expect {
        user.update_attribute(:email, "foo@_.com")
      }.to violate_check_constraint(:email_must_be_valid_email)
    end
  end
end
