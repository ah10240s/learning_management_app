module StudyplansHelper

    # 開始日時・終了日時（Timeクラスの値）を「yyyy/mm/dd(w) hh:mm」に変換
    def format_change_datetime(target)
        weeks = ["月","火","水","木","金","土","日"]
        index = target.strftime("%u").to_i
        target.strftime("%Y/%m/%d(#{weeks[index - 1]}) %H:%M")
    end




end
