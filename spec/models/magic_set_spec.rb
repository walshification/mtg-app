require 'rails_helper'

RSpec.describe MagicSet, type: :model do
  it "makes a valid set without requirements" do
    expect(MagicSet.new).to be_valid
  end
end
