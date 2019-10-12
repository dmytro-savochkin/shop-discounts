# frozen_string_literal: true

module Orders
  module Discounters
    class LateFoodDiscounter < BaseDiscounter
      DISCOUNT_VALUE = BigDecimal('5.0')
      APPLICABLE_HOURS = (18..23).freeze
      CATEGORY_NAME = 'Food'

      private_constant :DISCOUNT_VALUE, :HOURS, :CATEGORY_NAME

      def initialize(order:, **_)
        raise ArgumentError unless order.is_a?(::Order)

        @order = order
      end

      def applicable?
        late_hour? && food_ordered?
      end

      def discount
        Discounts::ApplicableItems.new.call(
          items: applicable_items,
          discount_value: DISCOUNT_VALUE
        )
      end

      private

      attr_reader :order

      # TODO: Maybe this should take into account the customer time zone?
      # Depends on a type of the shop we are running.
      def late_hour?
        date = order.confirmed_or_higher? ? order.confirmed_at : Time.zone.now
        APPLICABLE_HOURS.include?(date.hour)
      end

      def food_ordered?
        applicable_items.present?
      end

      def applicable_items
        @applicable_items ||= order.order_items.select do |order_item|
          order_item.category_id == food_category_id
        end
      end

      # TODO: This can be cached.
      def food_category_id
        Category.find_by(name: CATEGORY_NAME).id
      end
    end
  end
end
