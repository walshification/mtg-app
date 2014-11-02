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
end
