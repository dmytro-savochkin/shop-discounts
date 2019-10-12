# frozen_string_literal: true

class Order < ApplicationRecord
  STATUSES = {
    created: 0,
    confirmed: 1,
    fulfilled: 2
  }.freeze

  private_constant :STATUSES

  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :order_discounts, dependent: :destroy

  monetize :total_cents

  enum status: STATUSES

  validates :customer_id, :total_cents, presence: true
  validates :status, inclusion: { in: STATUSES.values }

  def confirmed_or_higher?
    status >= STATUSES[:confirmed]
  end

  # TODO: This should have validation that
  # there is only one :created order for a customer.
end
