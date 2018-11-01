class RenameFeeFieldToFeeAmountOrders < ActiveRecord::Migration[5.2]
  def change
    change_table :orders do |t|
      t.rename :fee, :fee_amount
    end
  end
end
