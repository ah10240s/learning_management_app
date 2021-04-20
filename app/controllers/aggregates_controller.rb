class AggregatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    # GET: /aggregates
    # 科目一覧ページへ
    def index
        # debugger
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

        # render index

        # respond_to do |format|
        #     format.html { render index }
        #     format.js
        # end
        # debugger
    end


    # def index_ajax
    def aaa
        # debugger
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

        # render index

        respond_to do |format|
            format.html { render aaa }
            format.js
        end
        # debugger
    end

    # 基準日を含む1週間の日付ラベル
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
    def week_tally_studyplans(user,tally_basedate,select_flag)
        studyplans = user.studyplans.where(
            start_daytime: start_week_basedate(tally_basedate)..end_week_basedate(tally_basedate),
            done_flag: select_flag)
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
