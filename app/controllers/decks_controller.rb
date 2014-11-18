class DecksController < ApplicationController
  def index
    @decks = current_user.decks
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.new(params[:deck])

    if @deck.save
      flash[:success] = "Deck created successfully"
      redirect_to decks_path
    else
      render 'new'
    end
  end

  def edit
    @deck = Deck.find_by(:id => params[:id])
  end

  def show
    @card = Card.new
    @deck = Deck.find_by(:id => params[:id])
    @cards = @deck.cards.all
  end

  def update
    @deck = Deck.find_by(:id => params[:id])
    @deck.update(params[:deck])
    flash[:success] = "Deck updated."
    redirect_to deck_path(@deck.id)
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :legal_format, :deck_type)
  end
end
