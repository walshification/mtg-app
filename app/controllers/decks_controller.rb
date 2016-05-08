class DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
    @card = Card.new
    @deck = Deck.find(params[:id])
  end

  def update
  end

  def battlefield
  end

  def test_pusher
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :legal_format, :deck_type)
  end
end
