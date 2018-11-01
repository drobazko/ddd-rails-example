module Domain
  module Order
    class Order < Infra::Models::ApplicationRecord
      has_many :items, autosave: true

      attribute :customer, :string # just a string because we are lazy

      def fee
        Fee.new(self.fee_amount, self.currency)
      end

      def fee=(fee)
        self.fee_amount = fee.fee_amount
        self.currency = fee.currency
      end

      def add_product(product, quantity)
        raise Exceptions::BusinessException.new('Product already exists') if product_already_exists?(product)

        items << Item.new(quantity: quantity, product: product)
      end

      def change_product_quantity(product, quantity)
        validate_product_presence!(product)
        item = items.find { |item| item.product == product }
        item.change_quantity(quantity)
      end

      def remove_product(product)
        validate_product_presence!(product)
        items = self.items.reject { |item| item.product == product }
        self.items = items
      end

      private

      def product_already_exists?(product)
        items.select { |item| item.product == product }.present?
      end

      def validate_product_presence!(product)
        raise Exceptions::BusinessException.new('Product not found on item list') unless items.find { |item| item.product == product }.present?
      end
    end
  end
end
