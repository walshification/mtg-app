class CardsController < ApplicationController
  # def index
  # end

  def show
    @card = Card.find_by(:id => params[:id])
  end

  def new
  end

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    @card = TolarianRegistry::Card.new({:multiverse_id => @card["id"].to_i, :deck_id => params[:deck_id], :card_name => @card["name"], :image_url => "
    https://api.mtgdb.info/content/card_images/#{@card["id"]}.jpeg"})
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
