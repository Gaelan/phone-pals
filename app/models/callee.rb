class Callee < ApplicationRecord
  belongs_to :organization
  has_many :relationships
  has_many :users, through: :relationships

  def safe_name
    "#{first_name[0]}. #{last_name}"
  end

  RELATIONSHIP_LIMIT = 1

  def available_relationships
    RELATIONSHIP_LIMIT - relationships.count
  end

  def can_start_relationship?
    available_relationships > 0
  end
end
