class IndexRelationshipsOnCode < ActiveRecord::Migration[6.0]
  def change
    add_index :relationships, :code
  end
end
