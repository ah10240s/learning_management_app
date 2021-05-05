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

    validates :invite_user_id, presence: true


    #登録時＆ログイン時？にメールアドレスを不要とする
    # def email_required?
    #   false
    # end
  
    # def email_changed?
    #   false
    # end

  # #####################################
  # そのグループに参加していないか判定（アクセス制限用）
  # （非参加：true、参加中・招待中：false）
  # #####################################
  def check_access_notjoin_subject_group(subject_group)
    join_users = subject_group.subject_groups_joining_users
    if join_users then
      join_users.each do |user|
        if self.id == user.id then
          return false
        end
      end
    end

    invite_users = subject_group.subject_groups_inviting_users
    if invite_users then
      invite_users.each do |user|
        if self.id == user.id then
          return false
        end
      end
    end

    return true

  end


  # #####################################
  # そのグループに参加中か判定（アクセス制限用）
  # （参加中：ture、招待中・非参加：false）
  # #####################################
  def check_access_join_subject_group(subject_group)
    join_users = subject_group.subject_groups_joining_users
    if join_users then
      join_users.each do |user|
        if self.id == user.id then
          return true
        end
      end
    end
    return false
  end




  # #####################################
  # そのグループに招待中か判定（アクセス制限用）
  # （招待中：ture、参加中・非参加：false）
  # #####################################
  def check_access_invite_subject_group(subject_group)

    invite_users = subject_group.subject_groups_inviting_users
    if invite_users then
      invite_users.each do |user|
        if self.id == user.id then
          return true
        end
      end
    end

    return false

  end




  # #####################################
  # 招待を受けているグループ一覧を返却
  # #####################################
  def inviting_subject_groups
    subjects = self.subjects
    return_date = []
    subjects.each do |subject|
      if subject.invit_subject_group_judge then
        membership_subject_groups = subject.membership_subject_groups.order(id: :DESC).first
        return_date << SubjectGroup.find(membership_subject_groups.subject_group_id)
      end
    end
    return return_date
  end


  # #####################################
  # 招待中でない（有効な）科目一覧を返却
  # #####################################
  def notinvite_subjects
    subjects = self.subjects
    return_date = []
    subjects.each do |subject|
      if subject.invit_subject_group_judge == false then
        return_date << subject
      end
    end
    return return_date
  end


  # #####################################
  # グループに参加中の科目一覧を返却
  # #####################################
  def joining_subject_group_subjects
    subjects = self.notinvite_subjects
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
    # subjects = self.subjects
    subjects = self.notinvite_subjects
    
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
    subjects = self.notinvite_subjects
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
  # alldate_flag：完了済、未完了関係なく全ての学習予定を返す場合は「true」、どちらかのみの場合は「false」
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
          if studyplan.done_flag == true then
            return_date << studyplan
          end
        end
      else
        # 未完了
        buf_studyplans.each do |studyplan|
          if studyplan.done_flag == false then
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
