require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'class methods' do 
    it 'destroys an invoice record if that record has no items' do 
      merchant_1 = Merchant.create!(name: Faker::Name.name)

      item_1 = Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: 500, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: Faker::Beer.name, description: "So good!", unit_price: 500, merchant_id: merchant_1.id )
  
      customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  
      invoice_1 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_2 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_3 = Invoice.create!(status: 0, created_at: Time.new(2000), customer_id: customer_1.id, merchant_id: merchant_1.id)
  
      invoice_item_3 = InvoiceItem.create!(quantity: 4, unit_price: 800, item_id: item_2.id, invoice_id: invoice_3.id)

      Invoice.destroy_invoices_with_no_items

      expect(Invoice.all.count).to eq(1)
    end
  end
end 