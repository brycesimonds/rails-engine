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
    json_response(Item.destroy(params[:id]))
    Invoice.destroy_invoices_with_no_items
  end

  def update
    json_response(ItemSerializer.new(Item.update(params[:id], item_params)))
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end