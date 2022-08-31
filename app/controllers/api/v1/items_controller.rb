class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  def index
    @items = Item.all
    json_response(ItemSerializer.new(@items))
  end

  def show
    json_response(ItemSerializer.new(@item))
  end

  def create
    # binding.pry
    json_response(ItemSerializer.new(Item.create(item_params)))
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end