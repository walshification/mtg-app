class DeckedCardsController < ApplicationController

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    @card = Unirest.get("http://api.mtgdb.info/cards/#{params[:card_name]}")
    @decked_card = DeckedCard.new(decked_card_params)
    if @decked_card.save
      flash[:success] = "Card successfully added!"
      redirect_to deck_path(@deck.id)
    else
      render 'new'
    end
  end

  private

  def decked_card_params
    params.permit(:card_name, :deck_id)
  end
end
