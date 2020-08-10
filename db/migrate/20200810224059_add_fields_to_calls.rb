class AddFieldsToCalls < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :seconds, :integer
    add_column :calls, :complete, :boolean
    add_column :calls, :incoming_number, :string

    remove_column :calls, :minutes
  end
end
