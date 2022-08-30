class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  def index
    @items = Item.all
    json_response(ItemSerializer.new(@items))
  end

  def show
    json_response(MerchantSerializer.new(@item))
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end