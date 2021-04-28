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
2.times do |n|
    user = User.new(
        email: "test#{n+1}@example.com",
        username: "テスト#{n+1}",
        password: "#{n+1}#{n+1}#{n+1}#{n+1}#{n+1}#{n+1}"
    )
    user.save!
end


# ##############################
# 科目データ
# ##############################
subjects_sumple = [
    "データベース", "応用情報", "基本情報", "Java Silver", "ネットワーク", 
    "情報安全確保", "ITストラテジスト", "システムアーキテクト","システム監査", "プロジェクトマネージャー", 
    "ITサービスマネージャ", "栄養士", "管理栄養士", "エンベデット", "Java Gold"
]
i = 1
subjects_sumple.each do |subject|
    Subject.create!(
        subject_name: subject,
        user_id: 1,
    )
    Subject.create!(
        subject_name: subject,
        user_id: 2,
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

