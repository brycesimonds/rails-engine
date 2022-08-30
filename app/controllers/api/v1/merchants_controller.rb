class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def items
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items)
  end
end