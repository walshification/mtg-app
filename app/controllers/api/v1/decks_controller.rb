class Api::V1::DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end

  def show
    @card = Card.new
    @deck = Deck.find(params[:id])
    @cards = @deck.cards
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      flash[:success] = "Deck created successfully"
    else
      flash[:error] = "Unable to save new deck"
    end
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(
      :name,
      :user_id,
      :legal_format,
      :deck_type,
      :color
    )
  end
end
