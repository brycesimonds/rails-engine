class Api::V1::ItemSearchesController < ApplicationController
  def index
    json_response(ItemSerializer.new(Item.search(params[:name])))
  end
end