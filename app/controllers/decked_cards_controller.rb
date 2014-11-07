class DeckedCardsController < ApplicationController

  def create
    card = Card.find_by(:name => params[:card_name])
    DeckedCard.create(:quantity => params[:quantity].to_i, :card_id => card.id)
  end
end
