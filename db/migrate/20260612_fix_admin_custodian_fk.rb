class FixAdminCustodianFk < ActiveRecord::Migration[7.1]
  def change
    # Because there is circular relationship between Custodian and Account via
    # Account belongs_to admin_custodian_id, when trying to delete an account and its dependent custodian,
    # it also tries to set admin_custodian_id to null, which is not allowed.
    # The current change set to null admin_custodian_id before deleteing and account at the DB level,
    
    remove_foreign_key :accounts, column: :admin_custodian_id
    add_foreign_key :accounts, :custodians, column: :admin_custodian_id, on_delete: :nullify
  end
end
