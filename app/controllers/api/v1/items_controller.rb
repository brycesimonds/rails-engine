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
    Invoice.all.each do |invoice|
      if invoice.items.empty?
        invoice.destroy 
      end
    end
    #^ how to use active record to do this ruby instead
    # invoice_ids_to_destroy = Invoice.where(items = []).pluck(:id)
    # Invoice.destroy(invoice_ids_to_destroy)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end