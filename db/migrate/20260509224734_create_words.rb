class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.references :child, null: false, foreign_key: true
      t.string :word, null: false
      
      t.timestamps
    end

    add_index :words, [:child_id, :word], unique: true
  end
end
