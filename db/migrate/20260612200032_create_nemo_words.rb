class CreateNemoWords < ActiveRecord::Migration[7.1]
  def change
    create_table :nemo_words do |t|
      t.references :nemo_child, null: false, foreign_key: true
      t.string :word, null: false

      t.timestamps
    end

    add_index :nemo_words, [:nemo_child_id, :word], unique: true
  end
end
