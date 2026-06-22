class AddSignToNemoWords < ActiveRecord::Migration[7.1]
  def change
    add_column :nemo_words, :sign, :boolean, default: false
  end
end
