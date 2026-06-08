class AddDateToWords < ActiveRecord::Migration[7.1]
  def change
    #Adding default value so the exisitng records have a date, due to
    #the imposibility of having a date null.
    add_column :words, :date, :date, null: false, default: Date.today
  end
end
