# frozen_string_literal: true

module Orders
  class GetDiscountersService
    AVAILABLE_DISCOUNT_CLASSES = [
      Discounters::LateFoodDiscounter,
      Discounters::MouseKeyboardDiscounter,
      Discounters::TenWhiteDiscounter
    ].freeze

    private_constant :AVAILABLE_DISCOUNT_CLASSES

    # TODO: This might be derived dynamically in the future
    # (or from the DB, which is even better).
    def call
      AVAILABLE_DISCOUNT_CLASSES
    end
  end
end

