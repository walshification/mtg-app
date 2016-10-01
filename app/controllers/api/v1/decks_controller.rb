class Api::V1::DecksController < ApplicationController

  # GET /api/v1/decks.json
  def index
    @decks = current_user.decks
  end

  # GET /api/v1/decks/:id.json
  def show
    @deck = Deck.find(params[:id])
    # respond_to
  end

  # POST /api/v1/decks.json
  def create
    @deck = Deck.new(deck_params)
    respond_to do |format|
      if @deck.save
        format.json { render json: @deck }
      else
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/decks/:id.json
  def update
    Deck.find(params[:id]).update(params[:deck])
  end

  # def create
  #   @deck = Deck.new(deck_params)
  #
  #   if @deck.save
  #     flash[:success] = "Deck created successfully"
  #   else
  #     flash[:error] = "Unable to save new deck"
  #   end
  #   redirect_to decks_path
  # end

  private

  # Whitelists params allowed for deck creation nested inside a deck hash
  def deck_params
    params.require(:deck).permit(
      :name,
      :user_id,
      :legal_format,
      :deck_type,
      :color,
    )
  end
end
