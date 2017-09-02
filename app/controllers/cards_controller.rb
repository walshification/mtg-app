class CardsController < ApplicationController
  def index
    respond_to do |format|
      format.html {}
      format.json { render json: @cards }
    end
  end
end
