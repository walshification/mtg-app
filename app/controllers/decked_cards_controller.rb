class DeckedCardsController < ApplicationController

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    card = Card.find_by(:name => params[:card_name])
    DeckedCard.create(:quantity => params[:quantity].to_i, :card_id => card.id, :deck_id => @deck.id)

    flash[:success] = 'Card successfully added!'
    redirect_to deck_path(@deck.id)
  end
end
