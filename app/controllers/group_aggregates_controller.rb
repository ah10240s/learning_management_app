class GroupAggregatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user


    # GET: /aggregates
    # 学習実績ページへ
    def index
        @subject_group = SubjectGroup.find(params[:id])

        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(@subject_group)

        if params[:byday_flag] then
            @select_byday_flag = params[:byday_flag]
            @select_basedate = Time.parse(params[:date])
            select_direction = params[:direction]
            @select_total_flag = params[:total_flag]
        else
            @select_byday_flag = "true"
            @select_basedate = Time.current
            select_direction = ""
            @select_total_flag = "false"
        end

        if params[:change_date_flag] then
            if params[:change_byday_flag] == "true" then
                if @select_byday_flag == "true" then
                    @select_basedate = Time.current
                else
                    @select_basedate = (Time.current) - 3.days
                end
            else
                if @select_total_flag == "false" then
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
                else
                    @select_basedate = Time.current
                end
            end
        end

        

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
                if @select_total_flag == "false" then
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
                else
                    # 累計の合計学習実績時間
                        # 累計の学習予定（完了済）
                        all_studyplans_total = extract_studyplans_done_notyet(user.studyplans, true)
                        all_group_studyplans_total = []
                        all_studyplans_total.each do |studyplan|
                            if studyplan.subject_id == subject.id
                                all_group_studyplans_total << studyplan
                            end
                        end
                        # 完了済の学習実績（秒）
                        @done_sum_studyhours << (sum_studyhours_int(all_group_studyplans_total) / 60).to_i
                        
                end
            end
            # ラベル（ユーザー名）
            @users_labels << user.username
        end

        if @select_byday_flag == "true" then
            @xlabel = "単日学習実績（ " + Studyplan.format_change_datetime_md(@select_basedate - 9.hours) + " )"
        else
            if @select_total_flag == "false" then
                @xlabel = "週間学習実績（ " + Studyplan.format_change_datetime_md(@select_basedate - 9.hours) + " 〜 " +
                Studyplan.format_change_datetime_md(@select_basedate + 5.days) + " )"
            else
                @xlabel ="累計学習実績"
            end
        end

        # @done_sum_studyhours << 1900
        # @users_labels << "ssss"
        @chart_size = group_aggregates_chart_size(@done_sum_studyhours)
        
    end


    private

        def group_aggregates_chart_size(arr)
            basis_size = (arr.size * 60) + 50
            if arr.size == 0 then
                return "min-height: 200px; height: 200px; max-height: 200px; width: 100%;"
            else
                return "min-height: #{(basis_size / 3).to_s}px; height: #{basis_size.to_s}px; max-height: #{(basis_size * 3).to_s}px; width: 100%;"
                # return "min-height: #{(basis_size / 2).to_s}px; height: #{basis_size.to_s}px; max-height: #{(basis_size * 2).to_s}px; width: 100%;"
            end
        end

end
