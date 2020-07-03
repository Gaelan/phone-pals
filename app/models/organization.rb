class Organization < ApplicationRecord
  has_many :callees
  has_many :organization_memberships
  has_many :users, through: :organization_memberships

  validates :switchboard_number, phone: { allow_blank: true, extensions: false }
end
