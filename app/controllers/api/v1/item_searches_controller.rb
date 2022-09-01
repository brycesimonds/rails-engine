class Api::V1::ItemSearchesController < ApplicationController
  def index
    if params[:name]
      json_response(ItemSerializer.new(Item.search_name(params[:name])))
    elsif params[:min_price]
      json_response(ItemSerializer.new(Item.search_min_price(params[:min_price])))
    elsif params[:max_price]
      json_response(ItemSerializer.new(Item.search_price(params[:max_price])))
    end
  end
end