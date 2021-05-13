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
6.times do |n|
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
    "情報安全確保", "ITストラテジスト", "システムアーキテクト","システム監査", "プロジェクトマネージャー"
    # "ITサービスマネージャ", "栄養士", "管理栄養士", "エンベデット", "Java Gold"
]

# 登録順がズレる為NG
# subjects_sumple.each do |subject|
#     for i in 1..6 do
#         Subject.create!(
#             subject_name: subject,
#             user_id: i
#         )
#     end
# end

subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 1
    )
end
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 2
    )
end
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 3
    )
end
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 4
    )
end
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 5
    )
end
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 6
    )
end


# ##############################
# 科目グループデータ
# ##############################

# 参加ユーザー1〜5
SubjectGroup.create!(
    name: "データベース勉強会",
    user_id: 1
)

# 参加ユーザー1〜5
# 招待中ユーザー6
SubjectGroup.create!(
    name: "応用情報勉強会",
    user_id: 2
)

# 参加ユーザー2〜3
# 招待中ユーザー1、6
SubjectGroup.create!(
    name: "基本情報勉強会",
    user_id: 2
)



# ##############################
# 学習予定データ
# ##############################
def set_done_flag
    if rand(1..2) == 1 then
        return true
    else
        return false
    end
end

basedate = (Time.now) - 10.days

20.times do |n|

    signup_basedate = basedate + n.days



    # グループ1〜2
    # 科目1〜2
    # ユーザー1〜5

    # for i in 1..5 do
    #     Studyplan.create!(
    #         user_id: i, 
    #         subject_id: rand(1..2), 
    #         start_daytime: (signup_basedate.change(hour: rand(9..12))) + 9.hours, 
    #         end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))) + 9.hours, 
    #         done_flag: done_flag
    #     )
    # end

    Studyplan.create!(
        user_id: 1, 
        subject_id: rand(1..2), 
        start_daytime: (signup_basedate.change(hour: rand(9..12))), 
        end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        done_flag: set_done_flag
    )
    Studyplan.create!(
        user_id: 2, 
        subject_id: rand(11..12), 
        start_daytime: (signup_basedate.change(hour: rand(9..12))), 
        end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        done_flag: set_done_flag
    )
    Studyplan.create!(
        user_id: 3, 
        subject_id: rand(21..22), 
        start_daytime: (signup_basedate.change(hour: rand(9..12))), 
        end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        done_flag: set_done_flag
    )
    Studyplan.create!(
        user_id: 4, 
        subject_id: rand(31..32), 
        start_daytime: (signup_basedate.change(hour: rand(9..12))), 
        end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        done_flag: set_done_flag
    )
    Studyplan.create!(
        user_id: 5, 
        subject_id: rand(41..42), 
        start_daytime: (signup_basedate.change(hour: rand(9..12))), 
        end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        done_flag: set_done_flag
    )

    # 科目4〜10
    # ユーザー1〜5
    # if rand(1..2) == 1 then
    #     for i in 1..5 do
    #         Studyplan.create!(
    #             user_id: i, 
    #             subject_id: rand(4..10), 
    #             start_daytime: (signup_basedate.change(hour: rand(9..12))) + 9.hours, 
    #             end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))) + 9.hours, 
    #             done_flag: done_flag
    #         )
    #     end
    # end

    if rand(1..2) == 1 then
        Studyplan.create!(
            user_id: 1, 
            subject_id: rand(4..10), 
            start_daytime: (signup_basedate.change(hour: rand(9..12))), 
            end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
            done_flag: set_done_flag
        )
        Studyplan.create!(
            user_id: 2, 
            subject_id: rand(14..20), 
            start_daytime: (signup_basedate.change(hour: rand(9..12))), 
            end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
            done_flag: set_done_flag
        )
        Studyplan.create!(
            user_id: 3, 
            subject_id: rand(24..30), 
            start_daytime: (signup_basedate.change(hour: rand(9..12))), 
            end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
            done_flag: set_done_flag
        )
        Studyplan.create!(
            user_id: 4, 
            subject_id: rand(34..40), 
            start_daytime: (signup_basedate.change(hour: rand(9..12))), 
            end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
            done_flag: set_done_flag
        )
        Studyplan.create!(
            user_id: 5, 
            subject_id: rand(44..50), 
            start_daytime: (signup_basedate.change(hour: rand(9..12))), 
            end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
            done_flag: set_done_flag
        )
    end

end




# ##############################
# 科目グループデータ
# ##############################

basedate = (Time.now) - 10.days

# グループ1
# ユーザー1〜5
# 参加者
for i in 1..5 do
    MembershipSubjectGroup.create!(
        subject_id: i + ((i - 1) * 10) - (i - 1),
        subject_group_id: 1,
        joined_at: basedate
    )
end




# グループ2
# ユーザー1〜5
# 参加者
for i in 1..5 do
    MembershipSubjectGroup.create!(
        subject_id: i + ((i - 1) * 10) - (i - 1) + 1,
        subject_group_id: 2,
        joined_at: basedate
    )
end

# グループ2
# ユーザー6
# 招待
MembershipSubjectGroup.create!(
    subject_id: 52,
    subject_group_id: 2,
    joined_at: nil
)


# グループ3
# ユーザー2〜3
# 参加者
for i in 2..3 do
    MembershipSubjectGroup.create!(
        subject_id: i + ((i - 1) * 10) - (i - 1) + 2,
        subject_group_id: 3,
        joined_at: basedate
    )
end

# グループ3
# ユーザー1
# 招待
MembershipSubjectGroup.create!(
    subject_id: 3,
    subject_group_id: 3,
    joined_at: nil
)





# # ##############################
# # 学習予定データ
# # ##############################

# basedate = (Time.now) - 10.days

# 20.times do |n|
#     signup_basedate = basedate + n.days
#     if rand(1..2) == 1 then
#         done_flag = true
#     else
#         done_flag = false
#     end

#     Studyplan.create!(
#         user_id: 1, 
#         subject_id: rand(1..15), 
#         # start_daytime: (signup_basedate.change(hour: rand(9..12))) + 9.hours, 
#         # end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))) + 9.hours, 
#         start_daytime: (signup_basedate.change(hour: rand(9..12))), 
#         end_daytime: (signup_basedate.change(hour: rand(18..20), min: rand(0..59))), 
        
#         done_flag: done_flag
#     )
    
# end


# # 参加中2つ（作成者、参加者）
# # 招待中1つ
# # 招待している
# # ##############################
# # 科目グループデータ
# # ##############################
# SubjectGroup.create!(
#     name: "グループ1（作成者、DB）",
#     user_id: 1
# )

# SubjectGroup.create!(
#     name: "グループ2（2のグループに参加、応用情報）",
#     user_id: 2
# )

# SubjectGroup.create!(
#     name: "グループ3（2のグループから招待を受けている、基本情報）",
#     user_id: 2
# )
# SubjectGroup.create!(
#     name: "グループ4（招待している、Java Silver）",
#     user_id: 1
# )
# SubjectGroup.create!(
#     name: "グループ5（3のグループから招待を受けている、ネットワーク）",
#     user_id: 3
# )

# # ##############################
# # 科目グループデータ
# # ##############################
# # 作成者　10.minutes
# basedate = (Time.now) + 9.hours
# MembershipSubjectGroup.create!(
#     subject_id: 1,
#     subject_group_id: 1,
#     joined_at: basedate
# )


# # 参加者
# MembershipSubjectGroup.create!(
#     subject_id: 2,
#     subject_group_id: 2,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 12,
#     subject_group_id: 2,
#     joined_at: basedate
# )

# # 招待を受けている
# MembershipSubjectGroup.create!(
#     subject_id:3,
#     subject_group_id: 3,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 13,
#     subject_group_id: 3,
#     joined_at: basedate
# )

# # 招待している
# MembershipSubjectGroup.create!(
#     subject_id:4,
#     subject_group_id: 4,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 14,
#     subject_group_id: 4,
#     joined_at: nil
# )

# # 招待を受けている2
# MembershipSubjectGroup.create!(
#     subject_id:5,
#     subject_group_id: 5,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 25,
#     subject_group_id: 5,
#     joined_at: basedate
# )


# # 全グループに参加
# MembershipSubjectGroup.create!(
#     subject_id: 31,
#     subject_group_id: 1,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 32,
#     subject_group_id: 2,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 33,
#     subject_group_id: 3,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 34,
#     subject_group_id: 4,
#     joined_at: basedate
# )
# MembershipSubjectGroup.create!(
#     subject_id: 35,
#     subject_group_id: 5,
#     joined_at: basedate
# )

# # 全グループに招待を受けている
# MembershipSubjectGroup.create!(
#     subject_id: 41,
#     subject_group_id: 1,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 42,
#     subject_group_id: 2,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 43,
#     subject_group_id: 3,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 44,
#     subject_group_id: 4,
#     joined_at: nil
# )
# MembershipSubjectGroup.create!(
#     subject_id: 45,
#     subject_group_id: 5,
#     joined_at: nil
# )