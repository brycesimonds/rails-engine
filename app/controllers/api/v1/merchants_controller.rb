class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]
  def index
    @merchants = Merchant.all
    json_response(MerchantSerializer.new(@merchants))
    # render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    json_response(MerchantSerializer.new(@merchant))
    # render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def items
    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      json_response(ItemSerializer.new(merchant.items))
      # render json: ItemSerializer.new(merchant.items)
    else
      render status: 404
    end 
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end