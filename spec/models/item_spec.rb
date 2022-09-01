require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'class methods' do 
    it 'can perform a case insensitive name search and returns first alphabetical item' do
      merchant = Merchant.create!(name: "Harold the Big")

      item_1 = Item.create!(name: "Peach", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_2 = Item.create!(name: "Pineapple", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)

      expect(Item.search_name("p")).to eq(item_1)
      expect(Item.search_name("P")).to eq(item_1)
      expect(Item.search_name("pEa")).to eq(item_1)
      expect(Item.search_name("bEr")).to eq(item_4)
    end

    it 'if in search method, no result is found, returns nil' do
      merchant = Merchant.create!(name: "Harold the Big")

      item_1 = Item.create!(name: "Peach", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_2 = Item.create!(name: "Pineapple", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)
      item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: Faker::Number.decimal(l_digits: 2), merchant_id: merchant.id)

      expect(Item.search_name("XXX")).to eq(nil)
    end

    it 'can search by minimum price and return one first object in an alphabitzed list' do
      merchant = Merchant.create!(name: "Harold the Big")

      item_1 = Item.create!(name: "Cherry", description: Faker::Beer.style, unit_price: 10.00, merchant_id: merchant.id)
      item_2 = Item.create!(name: "Apple", description: Faker::Beer.style, unit_price: 49.99, merchant_id: merchant.id)
      item_3 = Item.create!(name: "Pear", description: Faker::Beer.style, unit_price: 50.00, merchant_id: merchant.id)
      item_4 = Item.create!(name: "Berry", description: Faker::Beer.style, unit_price: 50.01, merchant_id: merchant.id)

      expect(Item.search_price(50.00)).to eq(item_4)
      expect(Item.search_price(9.00)).to eq(item_2)
      expect(Item.search_price(2.00)).to eq(item_2)
      expect(Item.search_price(50.01)).to eq(item_4)
    end
  end
end 