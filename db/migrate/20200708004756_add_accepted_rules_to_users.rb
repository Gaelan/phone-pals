class AddAcceptedRulesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accepted_rules, :boolean
  end
end
