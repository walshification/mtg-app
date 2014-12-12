class Api::V1::DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find_by(id: params[:id])
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      flash[:success] = "Deck created successfully"
      redirect_to decks_path
    else
      render 'new'
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :legal_format, :deck_type)
  end
end
