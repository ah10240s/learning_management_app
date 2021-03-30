class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 4, maximum: 20 },
    presence: true
end
