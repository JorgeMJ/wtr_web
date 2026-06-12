class CreateNemoChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :nemo_children do |t|
      t.integer :child_id, null: false

      t.timestamps
    end
  end
end
