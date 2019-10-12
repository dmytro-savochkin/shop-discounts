# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :category, index: true, null: false
      t.belongs_to :sub_category, index: true
      t.belongs_to :color, index: true
      t.string :name, index: true, null: false
      t.timestamps null: false
    end

    add_index :products, %i[category_id subcategory_id]

    add_foreign_key :products, :categories
    add_foreign_key :products, :sub_categories
    add_foreign_key :products, :colors

    add_monetize :products, :price, currency: { present: false }
  end
end
