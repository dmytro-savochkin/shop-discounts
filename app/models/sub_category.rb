# frozen_string_literal: true

class SubCategory < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true
end
