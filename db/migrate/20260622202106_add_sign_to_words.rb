class AddSignToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :sign, :boolean, default: false
  end
end
