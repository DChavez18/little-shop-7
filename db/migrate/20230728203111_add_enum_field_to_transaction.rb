class AddEnumFieldToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :result, :string
  end
end
