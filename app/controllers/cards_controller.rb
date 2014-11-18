class CardController < ApplicationController

  def show
    @card = Unirest.get("http://api.mtgdb.info/#{params[:id]}").body

    # @card = Card.find_by(:mutliverse_id => params[:id])
  end
end
