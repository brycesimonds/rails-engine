class Api::V1::MerchantSearchesController < ApplicationController
  def index
    binding.pry
    # @merchants = Merchant.all
    # json_response(MerchantSerializer.new(@merchants))
  end

  # private

  # def set_merchant
  #   @merchant = Merchant.find(params[:id])
  # end
end