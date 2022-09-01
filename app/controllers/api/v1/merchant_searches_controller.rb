class Api::V1::MerchantSearchesController < ApplicationController
  def index
    json_response(MerchantSerializer.new(Merchant.search(params[:name])))
  end
end