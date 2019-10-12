# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category, optional: true
  belongs_to :color, optional: true

  monetize :price_cents

  validates :category_id, :name, :price_cents, presence: true
end
