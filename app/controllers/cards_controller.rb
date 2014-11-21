class CardsController < ApplicationController
  # def index
  # end

  def show
    @card = Card.find_by(:id => params[:id])
    api_card = Unirest.get("http://api.mtgdb.info/cards/#{@card.multiverse_id}").body
    # @tcg_player = MtgPricer::Pricer.new.tcgplayer_price(@card.card_name)
    @cfb = MtgPricer::Pricer.new.cfb_price(@card.card_name, api_card["cardSetName"])
    # @ebay = MtgPricer::Pricer.new.ebay_price(@card.card_name)

    # @card = Card.find_by(:multiverse_id => params[:id])
  end

  def new
  end

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    @card = Unirest.get("http://api.mtgdb.info/cards/#{params[:card_name]}").body[0]
    @card = Card.new({:multiverse_id => @card["id"].to_i, :deck_id => params[:deck_id], :card_name => @card["name"]})
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
