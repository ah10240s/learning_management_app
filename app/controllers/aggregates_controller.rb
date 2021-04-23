class AggregatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    # GET: /aggregates
    # 科目一覧ページへ
    def index
        if params[:flag] then
            @select_done_flag = ActiveRecord::Type::Boolean.new.cast(params[:flag])
            @select_basedate = Time.parse(params[:date])
            @select_direction = params[:direction]
        else
            @select_done_flag = true
            @select_basedate = Time.now
            @select_direction = ""
        end

        if params[:change_date_flag] then
            if params[:change_date_flag] == "true" then
                if @select_direction == "before" then
                    @select_basedate = @select_basedate - 7.days
                else
                    @select_basedate = @select_basedate + 7.days
                end
            end
        end

        @studyplans = @user.week_tally_studyplans(@select_basedate, @select_done_flag)
        @array = week_datetime_label(@select_basedate)
        @date = week_aggregates(@select_basedate, @select_done_flag)

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


    # def index_ajax
    def index_ajax
        if params[:flag] then
            @select_done_flag = ActiveRecord::Type::Boolean.new.cast(params[:flag])
            @select_basedate = Time.parse(params[:date])
            @select_direction = params[:direction]
        else
            @select_done_flag = true
            @select_basedate = Time.now
            @select_direction = ""
        end

        if params[:change_date_flag] then
            if params[:change_date_flag] == "true" then
                if @select_direction == "before" then
                    @select_basedate = @select_basedate - 7.days
                else
                    @select_basedate = @select_basedate + 7.days
                end
            end
        end

        @studyplans = @user.week_tally_studyplans(@select_basedate, @select_done_flag)
        @array = week_datetime_label(@select_basedate)
        @date = week_aggregates(@select_basedate, @select_done_flag)

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


        # render index

        respond_to do |format|
            format.html { redirect_to aggregates_path }
            format.js
        end
        # debugger
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


    # 基準日を含む1週間の学習実績
    def week_tally_allstudyplans(user,tally_basedate)
        studyplans = user.studyplans.where(
            start_daytime: (start_week_basedate(tally_basedate)+ 9.hours)..(end_week_basedate(tally_basedate)+ 9.hours))
    end

        # 3日前の日にちを返す
        def start_week_basedate(basedate)
            start_date = basedate - 3.days
            start_date.change(hour: 0)
        end


        # 3日後の日にちを返す
        def end_week_basedate(basedate)
            end_date = basedate + 3.days
            end_date.change(hour: 23, min: 59)
        end

end
