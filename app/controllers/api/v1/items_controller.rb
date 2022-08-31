class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  def index
    @items = Item.all
    json_response(ItemSerializer.new(@items))
  end

  def show
    json_response(ItemSerializer.new(@item))
  end

  def create
    json_response(ItemSerializer.new(Item.create(item_params)), :created)
  end

  def destroy
    # render json: Item.delete(params[:id])
    # json_response(Item.delete(params[:id]), :no_content)
    # json_response(Item.delete(params[:id]))
    # json_response(ItemSerializer.new(Item.delete(params[:id])), :no_content)
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end