class Studyplan < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  
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
