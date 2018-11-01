class AddFeeAndCurrencyFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :fee, :decimal, precision: 5, scale: 2
    add_column :orders, :currency, :string
  end
end
