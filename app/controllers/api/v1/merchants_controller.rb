class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]
  def index
    @merchants = Merchant.all
    json_response(MerchantSerializer.new(@merchants))
  end

  def show
    json_response(MerchantSerializer.new(@merchant))
  end

  def items
    merchant = Merchant.find(params[:merchant_id])
    json_response(ItemSerializer.new(merchant.items))
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end