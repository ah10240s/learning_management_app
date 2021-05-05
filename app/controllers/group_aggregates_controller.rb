class GroupAggregatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user


# 週別か、日別か
# ユーザーごとの合計勉強時間（週別 or 日別）


    # GET: /aggregates
    # 学習実績ページへ
    def index

        # @date
        # @byday_flag
        # change_byday_flag
        # change_date_flag
        # direction

        if params[:byday_flag] then
            @select_byday_flag = params[:byday_flag]
            @select_basedate = Time.parse(params[:date])
            select_direction = params[:direction]
        else
            @select_byday_flag = "true"
            @select_basedate = Time.now
            select_direction = ""
        end

        if params[:change_date_flag] then
            if params[:change_byday_flag] == "true" then
                if @select_byday_flag == "true" then
                    @select_basedate = Time.now
                else
                    @select_basedate = (Time.now) - 3.days
                end
            else
                if select_direction == "before" then
                    if @select_byday_flag == "true" then
                        @select_basedate = @select_basedate - 1.days
                    else
                        @select_basedate = @select_basedate - 7.days
                    end
                else
                    if @select_byday_flag == "true" then
                        @select_basedate = @select_basedate + 1.days
                    else
                        @select_basedate = @select_basedate + 7.days
                    end
                end
            end
        end

        @subject_group = SubjectGroup.find(params[:id])

        # グループに参加している全ユーザー
        users = @subject_group.subject_groups_joining_users

        @done_sum_studyhours = []
        @users_labels = []

        users.each do |user|
            # このグループの所属科目テーブルにある、特定ユーザーの科目
            subject = @subject_group.subject_groups_createuser_subject(user)

            if @select_byday_flag == "true" then
                # 1日の合計学習実績時間
                all_studyplans_byday = user.byday_studyplans(@select_basedate, false, true)
                all_group_studyplans_byday = []
                all_studyplans_byday.each do |studyplan|
                    if studyplan.subject_id == subject.id
                        all_group_studyplans_byday << studyplan
                    end
                end

                # 完了済の学習実績（秒）
                @done_sum_studyhours << (sum_studyhours_int(all_group_studyplans_byday) / 60).to_i

            else
                # 1週間の合計学習実績時間
                    # 1週間の学習予定（完了済）
                    all_studyplans_week = user.week_studyplans(@select_basedate, false, true)
                    all_group_studyplans_week = []
                    all_studyplans_week.each do |studyplan|
                        if studyplan.subject_id == subject.id
                            all_group_studyplans_week << studyplan
                        end
                    end
                    # 完了済の学習実績（秒）
                    @done_sum_studyhours << (sum_studyhours_int(all_group_studyplans_week) / 60).to_i
                end
            # ラベル（ユーザー名）
            @users_labels << user.username
        end

        if @select_byday_flag == "true" then
            @xlabel = "単日学習実績（ " + Studyplan.format_change_datetime_md(@select_basedate - 9.hours) + " )"
        else
            @xlabel = "週間学習実績（ " + Studyplan.format_change_datetime_md(@select_basedate - 9.hours) + " 〜 " +
            Studyplan.format_change_datetime_md(@select_basedate + 5.days) + " )"
        end

    end

end
