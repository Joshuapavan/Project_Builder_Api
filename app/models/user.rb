class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
        :jwt_authenticatable,
        :registerable,
        jwt_revocation_strategy: JwtDenylist

  has_many :projects
  has_one :profile, class_name: "profile", foreign_key: "profile_id"
end
