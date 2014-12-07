class Api::V1::DecksController < ApplicationController
  def show
    @deck = Deck.find_by(id: params[:id])
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :legal_format, :deck_type)
  end
end
