class Api::V1::CardsController < ApplicationController
  def index
  end

  def show
    @card = Card.find_by(:id => params[:id])
  end

  def new
  end

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    lookup_card = TolarianRegistry::Card.find_by_name(params[:card_name])
    @card = Card.new(:multiverse_id => lookup_card.multiverse_id, :deck_id => params[:deck_id], :card_name => lookup_card.card_name)
    if @card.save
      flash[:success] = "Card successfully added!"
      redirect_to deck_path(@deck.id)
    else
      render 'new'
    end
  end

  private

  def card_params
    params.permit(:multiverse_id, :deck_id)
  end
end
