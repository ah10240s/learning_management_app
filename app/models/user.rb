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
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

    #登録時＆ログイン時？にメールアドレスを不要とする
    # def email_required?
    #   false
    # end
  
    # def email_changed?
    #   false
    # end




  def week_tally_studyplans(tally_basedate,select_flag)
    studyplans = self.studyplans.where(
        start_daytime: (start_week_basedate(tally_basedate)+ 9.hours)..(end_week_basedate(tally_basedate)+ 9.hours),
        done_flag: select_flag)
  end

    # 基準日を含む1週間の学習実績
    def week_tally_allstudyplans(tally_basedate)
      studyplans = self.studyplans.where(
          start_daytime: (start_week_basedate(tally_basedate)+ 9.hours)..(end_week_basedate(tally_basedate)+ 9.hours))
    end

private

  def start_week_basedate(basedate)
      start_date = basedate - 3.days
      start_date.change(hour: 0)
  end



  def end_week_basedate(basedate)
      end_date = basedate + 3.days
      end_date.change(hour: 23, min: 59)
  end


end
