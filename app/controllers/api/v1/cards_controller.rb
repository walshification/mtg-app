class Api::V1::CardsController < ApplicationController
  def index
    @card = Card.where("name LIKE ?", params[:card_name]).first
    puts @card
    respond_to do |format|
      format.html {}
      format.json { render json: @card }
    end
  end

  def show
    @card = Card.find_by(:id => params[:id])
  end

  def new
  end

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    lookup_card = TolarianRegistry::Card.find_by_name(params[:card_name])
    @card = Card.new({
      :multiverse_id => lookup_card.multiverse_id,
      :deck_id => params[:deck_id],
      :card_name => lookup_card.card_name,
      :image_url => lookup_card.image_url,
      :card_type => lookup_card.card_type,
      :card_subtype => lookup_card.card_subtype
    })
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
