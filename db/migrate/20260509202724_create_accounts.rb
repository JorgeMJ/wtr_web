class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      # Add this further head. For now, we just want the first iteration of the app to work
      # t.bigint :admin_custodian_id, null: false

      t.timestamps
    end
  end
end
