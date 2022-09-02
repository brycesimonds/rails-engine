class Api::V1::ItemSearchesController < ApplicationController
  def index
    if params[:min_price].to_i < 0 || params[:max_price].to_i < 0
      json_response({ error: 'Query not permitted' }, :bad_request)
    elsif params[:min_price].to_i < 0 || params[:max_price].to_i < 0
      render status: 400
    elsif params[:min_price] && params[:name]
      render status: 400
    elsif params[:max_price] && params[:name]
      render status: 400
    elsif params[:min_price] && params[:max_price] && params[:name]
      render status: 400
    elsif params[:min_price] && params[:max_price]
      json_response(ItemSerializer.new(Item.search_min_max_price(params[:min_price], params[:max_price])))
    elsif params[:min_price]
      if Item.search_min_price(params[:min_price]).nil?
        render json: {data: { } }
      else
        json_response(ItemSerializer.new(Item.search_min_price(params[:min_price])))
      end 
    elsif params[:max_price]
      json_response(ItemSerializer.new(Item.search_max_price(params[:max_price])))
    elsif params[:name]
      if Item.search_name(params[:name]).nil?
        render json: {data: { } }
      else
        json_response(ItemSerializer.new(Item.search_name(params[:name])))
      end
    end
  end
end

