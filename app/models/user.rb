class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  STUDENT_DOMAINS = ["edtools.psd401.net"]

  def student?
    STUDENT_DOMAINS.any? { |domain| email.ends_with? "@#{domain}" }
  end

  def organization_member?
    !organizations.empty?
  end

  protected
  def password_required?
    # To support setting up accounts for admins/org members: if someone's an
    # admin/org member, AND they've never had a password, their account have no
    # password.
    unless admin? || organization_member?
      super
    end

    if !encrypted_password.empty?
      super
    end

    false
  end

end
