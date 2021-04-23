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

        index()

        respond_to do |format|
            format.html { redirect_to aggregates_path }
            format.js
        end
        
    end



end
