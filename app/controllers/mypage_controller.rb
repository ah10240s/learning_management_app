class MypageController < ApplicationController

    def home
        # ログインしてないなら、ログインページ（/users/sign_in）にリダイレクト
        if !user_signed_in?
            redirect_to new_user_session_path
        end
    end
    
    def show

    end

end
