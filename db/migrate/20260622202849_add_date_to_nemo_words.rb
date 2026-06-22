class AddDateToNemoWords < ActiveRecord::Migration[7.1]
  def change
    add_column :nemo_words, :date, :date
  end
end
