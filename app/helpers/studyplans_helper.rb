module StudyplansHelper

    # 開始日時・終了日時（Timeクラスの値）を「yyyy/mm/dd(w) hh:mm」に変換
    def format_change_datetime(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%Y/%m/%d(#{weeks[index - 1]}) %H:%M")
    end

    # 勉強時間を算出
    def time_difference(before,after)
        difference = after - before
        hour = difference / 3600.0
        surplus = difference % 3600.0
        # debugger

        if surplus == 0.0 then
            "#{hour.to_i}:00"

        elsif hour < 1.0 then
            minutes = difference / 60.0
            "#{hour.to_i}:#{minutes.to_i}"

        else
            minutes = (difference - (hour.to_i * 3600)) / 60.0
            if minutes < 10.0 then
                "#{hour.to_i}:0#{minutes.to_i}"
            else
                "#{hour.to_i}:#{minutes.to_i}"
            end

        end
    end


end
