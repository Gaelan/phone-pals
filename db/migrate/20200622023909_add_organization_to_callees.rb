class AddOrganizationToCallees < ActiveRecord::Migration[6.0]
  def change
    add_reference :callees, :organization, null: false, foreign_key: true
  end
end
