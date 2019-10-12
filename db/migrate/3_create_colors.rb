# frozen_string_literal: true

class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps null: false
    end
  end
end
