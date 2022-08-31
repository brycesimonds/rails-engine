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

  it 'returns 404 if no such item id exists' do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/567"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)
    expect(response_body[:message]).to eq("Couldn't find Item with 'id'=567")
  end

  it 'can create a new item' do 
    merchant = create(:merchant)
    item_params = ({
      name: 'How do make items from an api for dummies',
      description: 'It is a book that may help junior devs',
      unit_price: 20.34,
      merchant_id: merchant.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can create and then delete an item' do
    merchant = create(:merchant)
    item_params = ({
      name: 'How do make items from an api for dummies',
      description: 'It is a book that may help junior devs',
      unit_price: 20.34,
      merchant_id: merchant.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect{ delete "/api/v1/items/#{created_item.id}" }.to change(Item, :count).by(-1)
    
    expect(response).to be_successful
    expect{Item.find(created_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'will delete an invoice associated with the deleted item if the invoice is then empty' do 
    merchant_1 = Merchant.create!(name: Faker::Name.name)

    item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
    # item_2 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )

    customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)

    invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id, merchant_id: merchant_1.id)

    invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, item_id: item_1.id, invoice_id: invoice_1.id)
    # invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1400, item_id: item_2.id, invoice_id: invoice_1.id)

  binding.pry
    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end 