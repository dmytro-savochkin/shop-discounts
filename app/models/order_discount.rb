# frozen_string_literal: true

class OrderDiscount < ApplicationRecord
  belongs_to :order

  validates :order_id, :discount_type, presence: true
  validate :validate_discount_type

  private

  def validate_discount_type
    return if Orders::GetDiscountersService.call.include?(discount_class)

    errors.add(:discount_type,
               I18n.t(:error_order_discount_invalid_discount_type))
  end

  def discount_class
    discount_type.safe_constantize
  end
end
