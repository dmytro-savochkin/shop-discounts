# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true, null: false
      t.belongs_to :product, index: true, null: false
      t.timestamps null: false
    end

    add_monetize :order_items, :price, currency: { present: false }
  end
end
