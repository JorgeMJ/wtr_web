class RemoveChildIdWordIndexFromWords < ActiveRecord::Migration[7.1]
  def change
    if index_exists?(:words, [:child_id, :word], name: "index_words_on_child_id_and_word")
      remove_index :words, name: "index_words_on_child_id_and_word"
    end
  end
end
