# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# ##############################
# ユーザーデータ
# ##############################
5.times do |n|
    user = User.new(
        email: "test#{n+1}@example.com",
        username: "ユーザー#{n+1}",
        password: "#{n+1}#{n+1}#{n+1}#{n+1}#{n+1}#{n+1}",
        invite_possible_flag: true,
        invite_user_id: SecureRandom.urlsafe_base64
    )
    user.save!
end


# ##############################
# 科目データ
# ##############################
subjects_sumple = [
    "データベース", "応用情報", "基本情報", "Java Silver", "ネットワーク", 
    "情報安全確保", "ITストラテジスト", "システムアーキテクト","システム監査", "プロジェクトマネージャー",
    # "ITサービスマネージャ", "栄養士", "管理栄養士", "エンベデット", "Java Gold"
]
i = 1
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 1
    )
    # Subject.create!(
    #     subject_name: subject,
    #     user_id: 2
    # )
    i = i + 1
end
i = 1
subjects_sumple.each do |subject|

    Subject.create!(
        subject_name: subject,
        user_id: 2
    )
    i = i + 1
end
i = 1
subjects_sumple.each do |subject|

    Subject.create!(
        subject_name: subject,
        user_id: 3
    )
    i = i + 1
end
i = 1
subjects_sumple.each do |subject|

    Subject.create!(
        subject_name: subject,
        user_id: 4
    )
    i = i + 1
end
i = 1
subjects_sumple.each do |subject|

    Subject.create!(
        subject_name: subject,
        user_id: 5
    )
    i = i + 1
end



# ##############################
# 学習予定データ
# ##############################

basedate = (Time.now) - 10.days

20.times do |n|
    signup_basedate = basedate + n.days
    if rand(1..2) == 1 then
        done_flag = true
    else
        done_flag = false
    end

    Studyplan.create!(
        user_id: 1, 
        subject_id: rand(1..15), 
        start_daytime: (signup_basedate.change(hour: rand(0..12))) + 9.hours, 
        end_daytime: (signup_basedate.change(hour: rand(13..23), min: rand(0..59))) + 9.hours, 
        done_flag: done_flag
    )
end


# 参加中2つ（作成者、参加者）
# 招待中1つ
# 招待している
# ##############################
# 科目グループデータ
# ##############################
SubjectGroup.create!(
    name: "グループ1（作成者、DB）",
    user_id: 1
)

SubjectGroup.create!(
    name: "グループ2（2のグループに参加、応用情報）",
    user_id: 2
)

SubjectGroup.create!(
    name: "グループ3（2のグループから招待を受けている、基本情報）",
    user_id: 2
)
SubjectGroup.create!(
    name: "グループ4（招待している、Java Silver）",
    user_id: 1
)
SubjectGroup.create!(
    name: "グループ5（3のグループから招待を受けている、ネットワーク）",
    user_id: 3
)

# ##############################
# 科目グループデータ
# ##############################
# 作成者　10.minutes
basedate = (Time.now) + 9.hours
MembershipSubjectGroup.create!(
    subject_id: 1,
    subject_group_id: 1,
    joined_at: basedate,
    withdrawn_at: nil
)


# 参加者
MembershipSubjectGroup.create!(
    subject_id: 2,
    subject_group_id: 2,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 12,
    subject_group_id: 2,
    joined_at: basedate,
    withdrawn_at: nil
)

# 招待を受けている
MembershipSubjectGroup.create!(
    subject_id:3,
    subject_group_id: 3,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 13,
    subject_group_id: 3,
    joined_at: basedate,
    withdrawn_at: nil
)

# 招待している
MembershipSubjectGroup.create!(
    subject_id:4,
    subject_group_id: 4,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 14,
    subject_group_id: 4,
    joined_at: nil,
    withdrawn_at: nil
)

# 招待を受けている2
MembershipSubjectGroup.create!(
    subject_id:5,
    subject_group_id: 5,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 25,
    subject_group_id: 5,
    joined_at: basedate,
    withdrawn_at: nil
)


# 全グループに参加
MembershipSubjectGroup.create!(
    subject_id: 31,
    subject_group_id: 1,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 32,
    subject_group_id: 2,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 33,
    subject_group_id: 3,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 34,
    subject_group_id: 4,
    joined_at: basedate,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 35,
    subject_group_id: 5,
    joined_at: basedate,
    withdrawn_at: nil
)

# 全グループに招待を受けている
MembershipSubjectGroup.create!(
    subject_id: 41,
    subject_group_id: 1,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 42,
    subject_group_id: 2,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 43,
    subject_group_id: 3,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 44,
    subject_group_id: 4,
    joined_at: nil,
    withdrawn_at: nil
)
MembershipSubjectGroup.create!(
    subject_id: 45,
    subject_group_id: 5,
    joined_at: nil,
    withdrawn_at: nil
)