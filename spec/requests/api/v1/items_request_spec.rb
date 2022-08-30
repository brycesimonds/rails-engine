require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'can get one item by its id' do
    item_1 = create(:item)
    item_2 = create(:item)


    get "/api/v1/items/#{item_1.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id].to_i).to eq(item_1.id)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
  end

  it 'returns 404 if no such item id exists' do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/567"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response_body[:message]).to eq("Couldn't find Item with 'id'=567")
  end
end 