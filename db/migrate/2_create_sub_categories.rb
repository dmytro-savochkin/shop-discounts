# frozen_string_literal: true

class CreateSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps null: false
    end
  end
end
