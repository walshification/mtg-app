class Api::V1::CardsController < ApplicationController
  PAGE_SIZE = 12

  # GET /api/v1/cards.json
  def index
    @page = (params[:page] || 0).to_i
    if params[:name]
      @cards = Card.where("name LIKE ?", params[:name]).
        offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    elsif params[:multiverse_id]
      @cards = [Card.find_by(multiverse_id: params[:multiverse_id])]
    else
      @cards = []
    end
  end

  # GET /api/v1/cards/:id.json
  def show
    @card = Card.find(params[:id])
  end

  # POST /api/v1/cards.json
  def create
    @deck = Deck.find(params[:deck_id])
    lookup_card = TolarianRegistry::Card.find_by_name(params[:card_name])
    @card = Card.new({
      multiverse_id: lookup_card.multiverse_id,
      deck_id: params[:deck_id],
      card_name: lookup_card.card_name,
      image_url: lookup_card.image_url,
      card_type: lookup_card.card_type,
      card_subtype: lookup_card.card_subtype,
    })
    if @card.save
      flash[:success] = "Card successfully added!"
      redirect_to deck_path(@deck.id)
    else
      render 'new'
    end
  end

  private

  # Whitelists params for adding a card to a deck.
  def card_params
    params.permit(:multiverse_id, :deck_id)
  end
end
