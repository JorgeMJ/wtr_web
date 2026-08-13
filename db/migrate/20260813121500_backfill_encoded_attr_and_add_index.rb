class BackfillEncodedAttrAndAddIndex < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:words, :encoded_attr)
      add_column :words, :encoded_attr, :string, null: false, default: ''
    end

    execute <<~SQL.squish
      UPDATE words
      SET encoded_attr = LOWER(word)
      WHERE encoded_attr IS NULL OR encoded_attr = ''
    SQL

    unless index_exists?(:words, [:child_id, :encoded_attr], name: 'index_words_on_child_id_and_encoded_attr')
      add_index :words, [:child_id, :encoded_attr], unique: true, name: 'index_words_on_child_id_and_encoded_attr'
    end
  end

  def down
    if index_exists?(:words, [:child_id, :encoded_attr], name: 'index_words_on_child_id_and_encoded_attr')
      remove_index :words, name: 'index_words_on_child_id_and_encoded_attr'
    end
  end
end
