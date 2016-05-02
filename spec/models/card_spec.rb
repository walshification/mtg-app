require 'rails_helper'

describe Card, :type => :model do
  describe "#new" do
    it "makes a new card" do
      expect(Card.new).to be_valid
    end
  end
end
