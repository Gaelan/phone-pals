class Callee < ApplicationRecord
  belongs_to :organization
  has_many :relationships
  has_many :users, through: :relationships
  has_many :calls
  validates :phone_number, phone: { allow_blank: true, extensions: false }

  RELATIONSHIP_LIMIT = 1

  def available_relationships
    RELATIONSHIP_LIMIT - relationships.count
  end

  def can_start_relationship?
    available_relationships > 0
  end

  def e164_number
    number =
      phone_number.empty? ? organization.switchboard_number : phone_number
    Phonelib.parse(number).e164
  end
end
