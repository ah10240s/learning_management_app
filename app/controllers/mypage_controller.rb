class MypageController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    def home
        # ログインしてないなら、ログインページ（/users/sign_in）にリダイレクト
        if !user_signed_in?
            redirect_to new_user_session_path
        end

        @select_basedate = (Time.current) - 3.days
        @all_studyplans_byday = @user.byday_studyplans(Time.current)
        @subjects = @user.notinvite_subjects

        all_studyplans_week = @user.week_studyplans(@select_basedate)
        done_studyplans_week = extract_studyplans_done_notyet(all_studyplans_week, true)
        notyet_studyplans_week = extract_studyplans_done_notyet(all_studyplans_week, false)

        @datatables_ylabels = multipledays_format_change_datetime_md(@select_basedate, 7)
        @done_week_studyhours = multipledays_studyhours_min(done_studyplans_week, @select_basedate, 7)
        notyet_week_studyhours = multipledays_studyhours_min(notyet_studyplans_week, @select_basedate, 7)

        @all_week_studyhours = multipledays_studyhours_min(all_studyplans_week, @select_basedate, 7)


        done_sum_studyhours_week = sum_studyhours_int(done_studyplans_week)
        all_sum_studyhours_week = sum_studyhours_int(all_studyplans_week)

        @done_sum_studyhours_week = time_conversion_hhmm(done_sum_studyhours_week)
        @all_sum_studyhours_week = time_conversion_hhmm(all_sum_studyhours_week)
        if done_sum_studyhours_week != 0 then
            @achievement_rate = ((done_sum_studyhours_week / all_sum_studyhours_week) * 100).round(1)
        else
            @achievement_rate = 0.0
        end

        # 招待を受けている科目グループ一覧
        @subject_groups = @user.inviting_subject_groups

    end
    
    def show
        
    end

end
