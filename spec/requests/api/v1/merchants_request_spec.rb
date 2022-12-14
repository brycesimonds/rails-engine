require 'rails_helper'

RSpec.describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

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

  it 'can get one merchant by its id' do
    merchant_1 = create(:merchant)
    merchant_1.items.create(attributes_for(:item))
    merchant_1.items.create(attributes_for(:item))

    get "/api/v1/merchants/#{merchant_1.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(merchant_1.id)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'returns 404 if no such merchant id exists' do
    merchant_1 = create(:merchant)
    merchant_1.items.create(attributes_for(:item))
    merchant_1.items.create(attributes_for(:item))

    get "/api/v1/merchants/567"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response_body[:message]).to eq("Couldn't find Merchant with 'id'=567")
  end

  it 'can get all items for a given merchant id' do
    merchant_1 = create(:merchant)
    merchant_1.items.create(attributes_for(:item))
    merchant_1.items.create(attributes_for(:item))

    merchant_2 = create(:merchant)
    merchant_2.items.create(attributes_for(:item))
    merchant_2.items.create(attributes_for(:item))
    
    get "/api/v1/merchants/#{merchant_1.id}/items"
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant_1_data = response_body[:data]

    expect(response).to be_successful
    expect(merchant_1_data.count).to eq(2)
  end

  it 'returns 404 if no such merchant id exists' do
    merchant_1 = create(:merchant)
    merchant_1.items.create(attributes_for(:item))
    merchant_1.items.create(attributes_for(:item))

    merchant_2 = create(:merchant)
    merchant_2.items.create(attributes_for(:item))
    merchant_2.items.create(attributes_for(:item))
    
    get "/api/v1/merchants/999999/items"
    
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response_body[:message]).to eq("Couldn't find Merchant with 'id'=999999")
  end
end