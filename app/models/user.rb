class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :subjects
  has_many :studyplans, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 4, maximum: 20 },
    presence: true

    #登録時＆ログイン時？にメールアドレスを不要とする
    def email_required?
      false
    end
  
    def email_changed?
      false
    end
end
