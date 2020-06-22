class CreateOrganizationMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_memberships do |t|
      t.belongs_to :organization, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
