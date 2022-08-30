class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]
  def index
    @merchants = Merchant.all
    json_response(@merchants)
    # render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    json_response(@merchant)
    # render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def items
    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    else
      render status: 404
    end 
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end