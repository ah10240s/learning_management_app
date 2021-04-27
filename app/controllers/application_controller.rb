class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?



    # #####################################
    # 全学習予定から、「完了済」or「未完了」のデータを取り出す 
    # #######################
    # studyplans：対象の学習予定
    # select_done_flag：取り出したい「done_flag」の値
    # #####################################
    def extract_studyplans_done_notyet(studyplans, select_done_flag)

        return_date = []
        if studyplans == nil || studyplans.count == 0 then
            return return_date
        end

        studyplans.each do |studyplan|
            if studyplan.done_flag == select_done_flag then
                return_date << studyplan
            end
        end
        return return_date
    end

    # #####################################
    # 指定期間の日付を「mm/dd(w)」に変換（Studyplan.format_change_datetime_mdの拡張版）
    # #####################################
    def multipledays_format_change_datetime_md(basedate, period_days)
        result = []
        for i in 1..period_days do
            result << Studyplan.format_change_datetime_md(basedate + (i - 1).days)
        end
        return result
    end


    # #####################################
    # 指定期間の勉強時間（分）を取得
    # #####################################
    def multipledays_studyhours_min(studyplans, basedate, period_days)
        
        if studyplans == nil || studyplans.count == 0 then
            return 0
        end

        result = []
        start = basedate.change(hour: 0)
        to = basedate.change(hour: 23, min: 59)

        for i in 1..period_days do

            sum = 0
            studyplans.each do |buf|
                if start <= buf.start_daytime && buf.start_daytime <= to then
                    sum = sum + (buf.daytime_difference() / 60).to_i
                end
            end

            result << sum
            start = start + 1.days
            to = to + 1.days

        end

        return result

    end


    # #####################################
    # 勉強時間の合算（秒）を取得
    # #####################################
    def sum_studyhours_int(studyplans)
        
        if studyplans == nil || studyplans.count == 0 then
            return 0
        else
            sum = 0
            studyplans.each do |buf|
                # debugger
                # sum = sum + ((buf.end_daytime - buf.start_daytime)/ 60.0).to_i
                sum = sum + buf.daytime_difference()
            end
            return sum
        end
        
    end


    # #####################################
    # 「秒」→「hh:mm」に変換
    # #####################################
    def time_conversion_hhmm(target)
        hour = target / 3600.0
        surplus = target % 3600.0

        if surplus == 0.0 then
            "#{hour.to_i}:00"

        elsif hour < 1.0 then
            minutes = target / 60.0
            "#{hour.to_i}:#{minutes.to_i}"

        else
            minutes = (target - (hour.to_i * 3600)) / 60.0
            if minutes < 10.0 then
                "#{hour.to_i}:0#{minutes.to_i}"
            else
                "#{hour.to_i}:#{minutes.to_i}"
            end

        end
    end

    # メールアドレスでもログイン出来るようにする。
    def configure_permitted_parameters
        added_attrs = [ :email, :username, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    # ユーザーをセット
    def set_current_user
        @user = current_user
    end

end
