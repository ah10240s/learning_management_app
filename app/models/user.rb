class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :subjects, dependent: :destroy
  has_many :studyplans, dependent: :destroy

  has_many :subject_groups, dependent: :destroy

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


  # #####################################
  # グループに参加中の科目一覧を返却
  # #####################################
  def joining_subject_group_subjects
    subjects = self.subjects
    return_date = []
    subjects.each do |subject|
      if subject.joining_subject_group_judge then
        return_date << subject
      end
    end
    return return_date
  end


  # #####################################
  # グループに参加していない科目一覧を返却
  # #####################################
  def not_joining_subject_group_subjects
    subjects = self.subjects
    return_date = []
    subjects.each do |subject|
      if subject.joining_subject_group_judge == false then
        return_date << subject
      end
    end
    return return_date
  end

  # #####################################
  # 参加している科目グループ一覧を返却
  # #####################################
  def joining_subject_groups
    subjects = self.subjects
    return_date = []
    subjects.each do |subject|
      if subject.joining_subject_group_judge then
        return_date << subject.joining_subject_group
      end
    end
    return return_date
  end


  # #####################################
  # 1週間の学習予定を返す（return_studyplansの拡張版）
  # #######################
  # tally_basedate：基準日（最過去日を指定する）
  # alldate_flag：完了済、未完了関係なく全ての学習予定を返す場合は「true」、どちらか飲みの場合は「false」
  # done_flag：alldate_flagが「false」の時飲み有効。完了済の学習予定を返す場合「true」、未完了の学習予定を返す場合「false」
  # #####################################
  def week_studyplans(tally_basedate, alldate_flag = true, done_flag = true)

    buf_studyplans = return_studyplans(tally_basedate, 7)
    return_date = []

    if alldate_flag == false then
      # 完了済 or 未完了の学習予定のみを抽出する場合

      if done_flag == true then
        # 完了済
        buf_studyplans.each do |studyplan|
          if studyplan.done_flag = true then
            return_date << studyplan
          end
        end
      else
        # 未完了
        buf_studyplans.each do |studyplan|
          if studyplan.done_flag = false then
            return_date << studyplan
          end
        end
      end

    else
      # 全ての学習予定を返す
      return_date = buf_studyplans
    end
    return return_date
  end

  # #####################################
  # 1日の学習予定を返す（return_studyplansの拡張版）
  # #######################
  # tally_basedate：基準日
  # alldate_flag：完了済、未完了関係なく全ての学習予定を返す場合は「true」、どちらか飲みの場合は「false」
  # done_flag：alldate_flagが「false」の時飲み有効。完了済の学習予定を返す場合「true」、未完了の学習予定を返す場合「false」
  # #####################################
  def byday_studyplans(tally_basedate, alldate_flag = true, done_flag = true)

    buf_studyplans = return_studyplans(tally_basedate)
    return_date = []

    if alldate_flag == false then
      # 完了済 or 未完了の学習予定のみを抽出する場合

      if done_flag == true then
        # 完了済
        buf_studyplans.each do |studyplan|
          if studyplan.done_flag = true then
            return_date << studyplan
          end
        end
      else
        # 未完了
        buf_studyplans.each do |studyplan|
          if studyplan.done_flag = false then
            return_date << studyplan
          end
        end
      end

    else
      # 全ての学習予定を返す
      return_date = buf_studyplans
    end
    return return_date
  end


  # #####################################
  # 学習予定をDBから取り出す  
  # #######################
  # basedate：基準日（最過去日を指定する）
  # period：複数日の学習予定を返す場合は、指定する
  # #####################################
  def return_studyplans(basedate, period = 1)

    period = period - 1
    start = basedate.change(hour: 0)
    to = basedate.change(hour: 23, min: 59)

    if period > 0 then
        to = to + period.days
    end
    result = self.studyplans.where(
        start_daytime: (start + 9.hours)..(to + 9.hours))
  end

end
