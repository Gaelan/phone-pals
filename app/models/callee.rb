class Callee < ApplicationRecord
  belongs_to :organization

  def safe_name
    "#{first_name[0]}. #{last_name}"
  end
end
