# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  user_id         :string           not null
#  hashed_password :string           not null
#  name            :string           not null
#  sex             :integer          not null
#  address         :string           not null
#  tel             :string           not null
#  birthday        :date             not null
#  email           :string           not null
#  admin_authority :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Member < ActiveRecord::Base
  belongs_to :reservation
  attr_accessor :password
  validates :user_id, presence: true,
            uniqueness: true
  validates :hashed_password, presence: true
  validates :name, presence: true
  validates :sex, presence: true
  validates :address, presence: true
  validates :tel, presence: true,
            numericality: { only_integer: true }
  validates :birthday, presence: true
  validates :email, presence: true

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  class << self
    def authenticate(user_id, password)
      member = find_by(user_id: user_id)
      if member && member.hashed_password.present? &&
        BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end
end
