class Call < ApplicationRecord
  belongs_to :callee
  belongs_to :user
end
