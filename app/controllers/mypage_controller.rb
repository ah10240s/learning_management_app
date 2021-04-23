class MypageController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    def home
        # ログインしてないなら、ログインページ（/users/sign_in）にリダイレクト
        if !user_signed_in?
            redirect_to new_user_session_path
        end

        @select_basedate = Time.now
        @studyplans = @user.studyplans.where(
            start_daytime: (@select_basedate.change(hour: 0) + 9.hours)..(@select_basedate.change(hour: 23, min: 59) + 9.hours))
        @subjects = @user.subjects
        

        @array = week_datetime_label(@select_basedate)
        @date_done = week_aggregates(@select_basedate, true)
        date_notyet = week_aggregates(@select_basedate, false)

        @date_all =[
                    (@date_done[0] + date_notyet[0]),
                    (@date_done[1] + date_notyet[1]),
                    (@date_done[2] + date_notyet[2]),
                    (@date_done[3] + date_notyet[3]),
                    (@date_done[4] + date_notyet[4]),
                    (@date_done[5] + date_notyet[5]),
                    (@date_done[6] + date_notyet[6])
        ]

        all_studyplans = @user.week_tally_allstudyplans(@select_basedate)
        done_date_time = week_aggregates_sum(true, all_studyplans)
        all_date_time = week_aggregates_sum(false, all_studyplans)

        @done_date_time = time_conversion_hhmm(done_date_time)
        @all_date_time = time_conversion_hhmm(all_date_time)
        if done_date_time != 0 then
            @achievement_rate = ((done_date_time / all_date_time) * 100).round(1)
        else
            @achievement_rate = 0.0
        end

    end
    
    def show
        
    end

end
# .layout-fixed .main-sidebar {
#     bottom: 0;
#     float: none;
#     left: 0;
#     position: fixed;
#     top: 0;
# }