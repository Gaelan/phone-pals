class AddSingleNameToCallees < ActiveRecord::Migration[6.0]
  def change
    add_column :callees, :name, :string

    Callee.all.each { |c| c.update(name: "#{c.first_name} #{c.last_name}") }

    remove_column :callees, :first_name
    remove_column :callees, :last_name
  end
end
