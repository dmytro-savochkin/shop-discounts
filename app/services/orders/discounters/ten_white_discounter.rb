# frozen_string_literal: true

module Orders
  module Discounters
    class TenWhiteDiscounter < BaseDiscounter
      DISCOUNT_VALUE = BigDecimal('1.0')
      REQUIRED_COUNT = 10
      COLOR_NAME = 'White'

      private_constant :DISCOUNT_VALUE, :REQUIRED_COUNT, :COLOR_NAME

      def initialize(order:, **_)
        raise ArgumentError unless order.is_a?(::Order)

        @order = order
      end

      def applicable?
        ten_white_present?
      end

      def discount
        Discounts::ApplicableItems.new.call(
          items: applicable_items,
          discount_value: DISCOUNT_VALUE
        )
      end

      private

      def ten_white_present?
        applicable_items.length >= REQUIRED_COUNT
      end

      def applicable_items
        @applicable_items ||= order.order_items.select do |order_item|
          applicable_color_id == order_item.color_id
        end
      end

      # TODO: This can be cached.
      def applicable_color_id
        Color.find_by(name: COLOR_NAME).id
      end
    end
  end
end

