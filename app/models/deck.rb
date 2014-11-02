class Deck < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user
end
