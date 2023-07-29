class ChangeResultsDataTypeInTransactions < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      ALTER TABLE transactions
      ALTER COLUMN result TYPE integer
      USING CASE result
             WHEN 'success' THEN 1
             WHEN 'failed' THEN 0
             ELSE NULL
           END;
    SQL
  end

  def down
    change_column :transactions, :result, :string
  end
end
