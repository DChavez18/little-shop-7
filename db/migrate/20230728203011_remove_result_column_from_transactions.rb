class RemoveResultColumnFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :result, :integer
  end
end
