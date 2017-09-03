# frozen_string_literal: true

# Controller for card operations.
class CardsController < ApplicationController
  # GET /cards
  def index
    respond_to do |format|
      format.html {}
      format.json { render json: @cards }
    end
  end
end
