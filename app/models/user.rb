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




  def week_tally_studyplans(tally_basedate,select_flag)
    studyplans = self.studyplans.where(
        start_daytime: (start_week_basedate(tally_basedate)+ 9.hours)..(end_week_basedate(tally_basedate)+ 9.hours),
        done_flag: select_flag)
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
