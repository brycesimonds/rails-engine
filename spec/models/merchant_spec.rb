require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'class methods' do 
    it 'can perform a case insensitive name search for a merchants' do
      merchant_1 = Merchant.create!(name: "Harold the Big")
      merchant_2 = Merchant.create!(name: "Hargret the Large")
      merchant_3 = Merchant.create!(name: "Harry the Giant")
      merchant_4 = Merchant.create!(name: "Suzy")

      expect(Merchant.search("har")).to eq([merchant_1, merchant_2, merchant_3])
    end
  end
end 
