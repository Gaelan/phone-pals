class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships
  has_many :relationships
  has_many :callees, through: :relationships

  STUDENT_DOMAINS = %w[.edu @edtools.psd401.net @stu.sumnersd.org @bprep.org]

  def student?
    STUDENT_DOMAINS.any? { |domain| email.ends_with? domain }
  end

  def organization_member?
    !organizations.empty?
  end

  RELATIONSHIP_LIMIT = 1

  def available_relationships
    RELATIONSHIP_LIMIT - relationships.count
  end

  def can_start_relationship?
    available_relationships > 0
  end

  protected

  def password_required?
    super unless admin? || organization_member? # To support setting up accounts for admins/org members: if someone's an admin/org member, AND they've never had a password, their account have no password.

    super if !encrypted_password.empty?

    false
  end
end
