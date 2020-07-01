class CreateCalls < ActiveRecord::Migration[6.0]
  def change
    create_table :calls do |t|
      t.belongs_to :callee, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :minutes
      t.text :details

      t.timestamps
    end
  end
end
