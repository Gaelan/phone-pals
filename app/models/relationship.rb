class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :callee

  def ensure_code!
    update(code: rand(100_000..999_999).to_s) unless code
  end

  def calls
    Call.where(user: user, callee: callee).order(call_date: :desc)
  end
end
