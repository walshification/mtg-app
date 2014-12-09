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

    @card_groups = {
      "Artifacts" => [],
      "Creatures" => [],
      "Enchantments" => [],
      "Instants" => [],
      "Basic Lands" => [],
      "Planeswalkers" => [],
      "Sorceries" => []
    }

    @cards.each do |card|
      sort_by_type(card)
    end
  end

  def update
    @deck = Deck.find_by(:id => params[:id])
    @deck.update(params[:deck])
    flash[:success] = "Deck updated."
    redirect_to deck_path(@deck.id)
  end

  def battlefield
    
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :user_id, :legal_format, :deck_type)
  end

  def sort_by_type(card)
    case card.card_type
    when "Artifact"
      @card_groups["Artifacts"] << card
    when "Creature"
      @card_groups["Creatures"] << card
    when "Enchantment"
      @card_groups["Enchaments"] << card
    when "Instant"
      @card_groups["Instants"] << card
    when "Basic Land"
      @card_groups["Basic Lands"] << card
    when "Planeswalker"
      @card_groups["Planeswalkers"] << card
    when "Sorcery"
      @card_groups["Sorceries"] << card
    end
  end
end
