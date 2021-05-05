class AggregatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

    # GET: /aggregates
    # 学習実績ページへ
    def index
        # 
        if params[:flag] then
            @select_done_flag = ActiveRecord::Type::Boolean.new.cast(params[:flag])
            @select_basedate = Time.parse(params[:date])
            @select_direction = params[:direction]
        else
            @select_done_flag = true
            @select_basedate = (Time.now) - 3.days
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


        all_studyplans_week = @user.week_studyplans(@select_basedate)
        @studyplans_week = extract_studyplans_done_notyet(all_studyplans_week, @select_done_flag)

        @datatables_ylabels = multipledays_format_change_datetime_md(@select_basedate, 7)
        @all_week_studyhours = multipledays_studyhours_min(@studyplans_week, @select_basedate, 7)

        done_sum_studyhours_week = sum_studyhours_int(extract_studyplans_done_notyet(all_studyplans_week, true))
        all_sum_studyhours_week = sum_studyhours_int(all_studyplans_week)

        @done_sum_studyhours_week = time_conversion_hhmm(done_sum_studyhours_week)
        @all_sum_studyhours_week = time_conversion_hhmm(all_sum_studyhours_week)
        if done_sum_studyhours_week != 0 then
            @achievement_rate = ((done_sum_studyhours_week / all_sum_studyhours_week) * 100).round(1)
        else
            @achievement_rate = 0.0
        end


    end


    # def index_ajax
    def index_ajax

        index()

        respond_to do |format|
            format.html { redirect_to aggregates_path }
            format.js
        end
        
    end



end
