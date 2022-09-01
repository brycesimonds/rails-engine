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

      expect(Item.search("p")).to eq([item_1, item_2, item_3])
      expect(Item.search("P")).to eq([item_1, item_2, item_3])
      expect(Item.search("bEr")).to eq([item_4])
    end
  end
end 