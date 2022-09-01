require 'rails_helper'

RSpec.describe "Merchant Searches API" do
  it "sends a list of all merchants who match the name fragment searched for" do
    merchant_1 = Merchant.create!(name: "Harold the Big")
    merchant_2 = Merchant.create!(name: "Hargret the Large")
    merchant_3 = Merchant.create!(name: "Harry the Giant")
    merchant_4 = Merchant.create!(name: "Suzy")

    get '/api/v1/merchants/find_all?name=har'
   
    expect(response).to be_successful
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end 