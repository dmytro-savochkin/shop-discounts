# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, index: true, null: false
      t.integer :status, index: true, null: false, default: 0
      t.datetime :confirmed_at
      t.timestamps null: false
    end

    add_monetize :orders, :total, currency: { present: false }
  end
end
