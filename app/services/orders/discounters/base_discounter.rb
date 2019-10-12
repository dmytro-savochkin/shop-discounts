# frozen_string_literal: true

module Orders
  module Discounters
    class BaseDiscounter
      def initialize(order:, customer:)
        @order = order
        @customer = customer
      end

      def applicable?
        raise NotImplementedError
      end

      def discount
        raise NotImplementedError
      end
    end
  end
end
