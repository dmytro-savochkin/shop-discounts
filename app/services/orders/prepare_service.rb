# frozen_string_literal: true

module Orders
  class PrepareService
    def initialize(customer:, product:, discounts_applier:)
      @customer = customer
      @product = product
      @discounts_applier = discounts_applier
    end

    def call
      add_product!
      apply_discounts!
      order
    end

    private

    attr_reader :customer, :product, :discounts_applier

    def order
      @order ||= Order.find_or_create_by!(customer: customer, status: :created)
    end

    def add_product!
      order.order_items.create!(product: product)
    end

    def apply_discounts!
      discounts_applier
        .new(discounter_getter: GetDiscountersService,
             order: order,
             customer: customer)
        .call
    end
  end
end

