class AddCallDateToCalls < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :call_date, :datetime

    Call.all.each { |call| call.update(call_date: call.created_at) }
  end
end
