class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def self.destroy_invoices_with_no_items
    self.all.each do |invoice|
      if invoice.items.empty?
        invoice.destroy 
      end
    end
  end
end 