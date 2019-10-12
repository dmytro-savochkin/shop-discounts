# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps null: false
    end
  end
end
