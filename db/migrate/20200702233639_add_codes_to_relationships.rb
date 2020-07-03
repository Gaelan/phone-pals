class AddCodesToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_column :relationships, :code, :string
  end
end
