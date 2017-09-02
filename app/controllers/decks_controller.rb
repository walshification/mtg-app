class DecksController < ApplicationController
  # GET /decks
  def index
    @decks = current_user.decks
  end

  # GET /decks/:id
  def show
    @card = Card.new
    @deck = Deck.find(params[:id])
  end

  # GET /battlefield
  def battlefield
    @opponent_id = User.find_by(email: "nemesis@gmail.com").id
  end

  def test_pusher
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
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
