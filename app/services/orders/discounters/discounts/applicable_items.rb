# frozen_string_literal: true

module Orders
  module Discounters
    module Discounts
      class ApplicableItems
        def call(items:, discount_value:)
          if items.blank? || discount_value.blank?
            raise ArgumentError,
                  I18n.t(:orders_discounters_discounts_applicable_items_blank)
          end
          unless (0..100).cover?(discount_value)
            raise ArgumentError,
                  I18n.t(:orders_discounters_discounts_applicable_items_incorrect_discount)
          end

          items.map do |item|
            item.price * discount_value / 100
          end.sum
        end
      end
    end
  end
end

