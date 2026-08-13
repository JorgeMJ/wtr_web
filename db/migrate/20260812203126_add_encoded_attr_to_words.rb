class AddEncodedAttrToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :encoded_attr, :string, null: false, default: ''
    add_index :words, [:child_id, :encoded_attr], unique: true, name: 'index_words_on_child_id_and_encoded_attr'
  end
end
