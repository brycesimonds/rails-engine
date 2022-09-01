require 'rails_helper'

RSpec.describe "Item Searches API" do
  it "sends an item who matches the name fragment searched for" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Peach", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_2 = Item.create!(name: "Pineapple", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)

    get '/api/v1/items/find?name=p'
   
    expect(response).to be_successful
    
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
    
    expect(item.count).to eq(1)

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