class CardsController < ApplicationController
  # def index
  # end

  def show
    @card = Unirest.get("http://api.mtgdb.info/#{params[:id]}").body

    # @card = Card.find_by(:mutliverse_id => params[:id])
  end

  def new
  end

  def create
    @deck = Deck.find_by(:id => params[:deck_id])
    @card = Unirest.get("http://api.mtgdb.info/cards/#{params[:card_name]}").body[0]
    puts "ADHJKSKASDHJKASDHFJKH"
    puts @card
    @card = Card.new({:multiverse_id => @card["id"].to_i, :deck_id => params[:deck_id]})
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
