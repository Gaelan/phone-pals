class AddPhoneNumbersToCallees < ActiveRecord::Migration[6.0]
  def change
    add_column :callees, :phone_number, :string
  end
end
