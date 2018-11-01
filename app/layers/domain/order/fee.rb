module Domain
  module Order
    class Fee < Struct.new(:fee_amount, :currency); end
  end
end
