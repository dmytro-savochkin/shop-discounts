# frozen_string_literal: true

class CreateOrderDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_discounts do |t|
      t.belongs_to :order, index: true
      t.string :discount_type, null: false
      t.timestamps null: false
    end
  end
end
