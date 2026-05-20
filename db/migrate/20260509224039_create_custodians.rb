class CreateCustodians < ActiveRecord::Migration[7.1]
  def change
    create_table :custodians do |t|
      t.references :account, null: false, foreign_key: true
      t.string :fname, null: false
      t.string :lname
      t.string :relationship_to_children
      t.boolean :is_admin
      t.string :email, null: false

      t.timestamps
    end
  end
end
