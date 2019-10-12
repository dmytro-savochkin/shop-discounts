# frozen_string_literal: true

module Orders
  class ApplyDiscountsService
    def initialize(discounter_getter:, order:, customer:)
      @discounter_getter = discounter_getter
      @order = order
      @customer = customer
    end

    def call
      ApplicationRecord.transaction do
        discounter_classes.each do |discounter_class|
          discounter = discounter_class.new(order: order, customer: customer)
          next unless discounter.applicable?

          order.total -= discounter.discount
          order.order_discounts.create!(discount_type: discounter.class)
        end
      end
    end

    private

    attr_reader :discounter_getter, :order, :customer

    def discounter_classes
      discounter_getter.new.call
    end
  end
end
