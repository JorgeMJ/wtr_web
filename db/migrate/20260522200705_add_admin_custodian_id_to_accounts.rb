class AddAdminCustodianIdToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :admin_custodian_id, :bigint
    # We need to add an index for the new column to improve query performance
    add_index  :accounts, :admin_custodian_id
    # Add a foreign key constraint to ensure referential integrity
    # becasue accounts belongs to the column admin_custodian_id in custodians table
    add_foreign_key :accounts, :custodians, column: :admin_custodian_id
  end
end
