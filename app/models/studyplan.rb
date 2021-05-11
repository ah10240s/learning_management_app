class Studyplan < ApplicationRecord
    belongs_to :user
    belongs_to :subject

    validates :start_daytime, presence: true
    validates :end_daytime, presence: true
    validates :done_flag, presence: true, allow_blank: true
    validate :date_before_end

    # #####################################
    # 「開始日時」≦「終了日時」となるかのバリデーション
    # #####################################
    def date_before_end
        return if end_daytime.blank? || start_daytime.blank?
        errors.add(:end_daytime, "は開始日以降のものを選択してください") if end_daytime < start_daytime
    end

    # #####################################
    # 勉強時間を算出（秒）
    # #####################################
    def daytime_difference
        difference = self.end_daytime - self.start_daytime
    end


    # #####################################
    # 勉強時間を算出（hh:mm）
    # #####################################
    def daytime_difference_hhmm
        difference = self.daytime_difference()
        result = self.class.time_conversion_hhmm(difference)
    end


    # #####################################
    # 「秒」→「hh:mm」に変換
    # #####################################
    def self.time_conversion_hhmm(target)
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
    
    # #####################################
    # 開始日時・終了日時（Timeクラスの値）を「yyyy/mm/dd(w) hh:mm」に変換
    # #####################################
    def self.format_change_datetime_full(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%Y/%m/%d(#{weeks[index - 1]}) %H:%M")
    end



    # #####################################
    # 開始日時・終了日時（Timeクラスの値）を「mm/dd(w)」に変換
    # #####################################
    def self.format_change_datetime_md(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%m/%d(#{weeks[index - 1]})")
    end

    # #####################################
    # 開始日時・終了日時（Timeクラスの値）を「yyyy/mm/dd(w)」に変換
    # #####################################
    def self.format_change_datetime_ymd(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%Y/%m/%d(#{weeks[index - 1]})")
    end

    # #####################################
    # 開始日時・終了日時（Timeクラスの値）を「yyyy-mm-dd」に変換
    # #####################################
    def self.format_change_datetime_ymd_fullcalendar(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%Y-%m-%d")
    end

end
