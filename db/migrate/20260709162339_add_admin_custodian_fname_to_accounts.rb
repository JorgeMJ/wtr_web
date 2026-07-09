class AddAdminCustodianFnameToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :admin_custodian_fname, :string
  end
end
