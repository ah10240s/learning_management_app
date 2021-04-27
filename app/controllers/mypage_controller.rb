class MypageController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    def home
        # ログインしてないなら、ログインページ（/users/sign_in）にリダイレクト
        if !user_signed_in?
            redirect_to new_user_session_path
        end

        @select_basedate = (Time.now) - 3.days
        @all_studyplans_byday = @user.byday_studyplans(@select_basedate)
        @subjects = @user.subjects

        all_studyplans_week = @user.week_studyplans(@select_basedate)
        done_studyplans_week = extract_studyplans_done_notyet(all_studyplans_week, true)
        notyet_studyplans_week = extract_studyplans_done_notyet(all_studyplans_week, false)

        @datatables_ylabels = multipledays_format_change_datetime_md(@select_basedate, 7)
        @done_week_studyhours = multipledays_studyhours_min(done_studyplans_week, @select_basedate, 7)
        notyet_week_studyhours = multipledays_studyhours_min(notyet_studyplans_week, @select_basedate, 7)

        @all_week_studyhours =[
                    (@done_week_studyhours[0] + notyet_week_studyhours[0]),
                    (@done_week_studyhours[1] + notyet_week_studyhours[1]),
                    (@done_week_studyhours[2] + notyet_week_studyhours[2]),
                    (@done_week_studyhours[3] + notyet_week_studyhours[3]),
                    (@done_week_studyhours[4] + notyet_week_studyhours[4]),
                    (@done_week_studyhours[5] + notyet_week_studyhours[5]),
                    (@done_week_studyhours[6] + notyet_week_studyhours[6])
        ]

        done_sum_studyhours_week = sum_studyhours_int(done_studyplans_week)
        all_sum_studyhours_week = sum_studyhours_int(all_studyplans_week)

        @done_sum_studyhours_week = time_conversion_hhmm(done_sum_studyhours_week)
        @all_sum_studyhours_week = time_conversion_hhmm(all_sum_studyhours_week)
        if done_sum_studyhours_week != 0 then
            @achievement_rate = ((done_sum_studyhours_week / all_sum_studyhours_week) * 100).round(1)
        else
            @achievement_rate = 0.0
        end

    end
    
    def show
        
    end

end
