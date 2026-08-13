class EnsureEncodedAttrOnWords < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:words, :encoded_attr)
      add_column :words, :encoded_attr, :string, null: false, default: ''
    end
    # index creation moved to a later backfill migration to avoid unique index errors
  end
end
