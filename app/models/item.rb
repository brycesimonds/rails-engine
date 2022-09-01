class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search_name(search_criteria)
    where("name ILIKE ?", "%#{search_criteria}%").order(:name).limit(1).first
  end

  def self.search_min_price(search_criteria)
    where('unit_price >= ?', search_criteria).order(:name).limit(1).first
  end

  def self.search_max_price(search_criteria)
    where('unit_price <= ?', search_criteria).order(:name).limit(1).first
  end
end 