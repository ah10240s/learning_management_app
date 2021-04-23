class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?



    protected

    def configure_permitted_parameters
        added_attrs = [ :email, :username, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
    def set_current_user
        @user = current_user
    end




    def week_aggregates_sum(select_flag,studyplans)
    
        difference_timea = 0
        
        if select_flag == false then
            # 全て抽出
            studyplans.each do |studyplan|
                difference_timea = difference_timea + (studyplan.end_daytime - studyplan.start_daytime)
            end
        else
            studyplans.each do |studyplan|
                # 完了済のみ抽出
                if studyplan.done_flag == true then
                    difference_timea = difference_timea + (studyplan.end_daytime - studyplan.start_daytime)
                end
            end
        end
        
        difference_timea

    end

    def time_conversion_hhmm(target)
        hour = target / 3600.0
        surplus = target % 3600.0
        # debugger

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



    # 基準日を含む1週間の時間を取得
    def week_aggregates(basedate,select_flag)
        startdate = start_week_basedate(basedate) 
        result = [ 
            extract_aggregates(startdate, select_flag),
            extract_aggregates(startdate.since(1.days), select_flag),
            extract_aggregates(startdate.since(2.days), select_flag),
            extract_aggregates(startdate.since(3.days), select_flag),
            extract_aggregates(startdate.since(4.days), select_flag),
            extract_aggregates(startdate.since(5.days), select_flag),
            extract_aggregates(startdate.since(6.days), select_flag)
        ]
    end

        # 開始日時・終了日時（Timeクラスの値）を「mm/dd(w)」に変換
        def extract_aggregates(target_date,select_flag)

            start = target_date.change(hour: 0)
            to = target_date.change(hour: 23, min: 59)
            # debugger
            result = @user.studyplans.where(
            start_daytime: (start + 9.hours)..(to + 9.hours),
            done_flag: select_flag)
            
            if result.count == 0 then
                return 0
            else
                sum = 0
                result.each do |studyplans|
                    sum = sum + ((studyplans.end_daytime - studyplans.start_daytime)/ 60.0).to_i
                end
                
                return sum
            end
            
        end

    # 基準日を含む1週間の日付ラベル
    def week_datetime_label(basedate)
        startdate = start_week_basedate(basedate) 
        result = [ 
            format_change_datetime_md(startdate),
            format_change_datetime_md(startdate.since(1.days)),
            format_change_datetime_md(startdate.since(2.days)),
            format_change_datetime_md(startdate.since(3.days)),
            format_change_datetime_md(startdate.since(4.days)),
            format_change_datetime_md(startdate.since(5.days)),
            format_change_datetime_md(startdate.since(6.days))
        ]
    end

        # 開始日時・終了日時（Timeクラスの値）を「mm/dd(w)」に変換
        def format_change_datetime_md(target)
            weeks = ["月","火","水","木","金","土","日"]
            index = target.strftime("%u").to_i
            target.strftime("%m/%d(#{weeks[index - 1]})")
        end

# 3日前の日にちを返す
def start_week_basedate(basedate)
    start_date = basedate - 3.days
    start_date.change(hour: 0)
end

end
