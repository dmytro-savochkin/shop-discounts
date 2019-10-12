# frozen_string_literal: true

module Orders
  module Discounters
    class MouseKeyboardDiscounter < BaseDiscounter
      DISCOUNT_VALUE = BigDecimal('3.0')
      SUB_CATEGORY_NAMES = %w[Mouse Keyboard].freeze

      private_constant :DISCOUNT_VALUE, :SUB_CATEGORY_NAMES

      def initialize(order:, **_)
        raise ArgumentError unless order.is_a?(::Order)

        @order = order
      end

      def applicable?
        mouse_and_keyboard_present?
      end

      def discount
        Discounts::ApplicableItems.new.call(
          items: applicable_items,
          discount_value: DISCOUNT_VALUE
        )
      end

      private

      def mouse_and_keyboard_present?
        applicable_items.lazy
                        .map(&:sub_category_id)
                        .uniq
                        .first(SUB_CATEGORY_NAMES.length)
                        .length == SUB_CATEGORY_NAMES.length
      end

      def applicable_items
        @applicable_items ||= order.order_items.select do |order_item|
          applicable_sub_category_ids.include?(order_item.sub_category_id)
        end
      end

      # TODO: This can be cached.
      def applicable_sub_category_ids
        @applicable_sub_category_ids ||=
          SubCategory.where(name: SUB_CATEGORY_NAMES).pluck(:id)
      end
    end
  end
end
