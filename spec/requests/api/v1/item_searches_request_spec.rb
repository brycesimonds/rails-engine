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
    
    expect(item[:attributes][:name]).to eq("Peach")

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

  it "sends null for a search with no results found" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Peach", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_2 = Item.create!(name: "Pineapple", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)

    get '/api/v1/items/find?name=XxXxX'
   
    expect(response).to be_successful
  
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(item).to eq({})
  end

  it "sends an item who matches the min price parameters searched for" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?min_price=50'
   
    expect(response).to be_successful
  
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
    
    expect(item[:attributes][:name]).to eq("Berry")

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

  it "sends an item who matches the max price parameters searched for" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Cherry", description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: "Apple", description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?max_price=50'
   
    expect(response).to be_successful
  
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
 
    expect(item[:attributes][:name]).to eq("Apple")

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

  it "sends an item who matches the min and max price parameters searched for" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Cherry", description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: "Apple", description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?max_price=150&min_price=50'
   
    expect(response).to be_successful
  
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
 
    expect(item[:attributes][:name]).to eq("Berry")

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

  it "returns a 400 status if min price is less than 0" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Cherry", description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: "Apple", description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?min_price=-12'

    expect(response.status).to eq(400)
  end 

  it "returns a 400 status if name is sent with min price" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: "Cherry", description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: "Apple", description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?name=berry&min_price=50'
   
    expect(response.status).to eq(400)
  end 

  it "errors if no item  matches the min price parameters searched for" do
    merchant = Merchant.create!(name: "Harold the Big")

    item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
    item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
    item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
    item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

    get '/api/v1/items/find?min_price=999999999'
   
    expect(response).to be_successful
  
    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]
   
    expect(item).to eq({})
  end
end 