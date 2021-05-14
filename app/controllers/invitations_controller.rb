class InvitationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user

# 退会日時の削除

    # # GET: /invitations
    # # 招待を受けている一覧ページへ
    # def index
    # end


    # def show
    # end


    # GET: /invitations/new
    # 招待作成ページへ
    def new
        
        @subject_group = SubjectGroup.find(params[:subject_group_id])

        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(@subject_group)

        @membership_subject_group = MembershipSubjectGroup.new
        @subject = Subject.new
        
    end

    # POST: /invitations
    # 招待作成処理
    def create
        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(SubjectGroup.find(params[:subject_group_id]))

        signup_user = User.where(invite_user_id: params[:invite_user_id]).first
        
        # 入力したユーザーが存在するか確認
        if signup_user == nil then
            flash[:danger] = "ユーザー共有idが正しくありません"
            redirect_to new_invitation_path(subject_group_id: params[:subject_group_id]) and return
        end

        # すでにグループに参加・招待されているか確認
        if signup_user.check_access_notjoin_subject_group(SubjectGroup.find(params[:subject_group_id])) == false then
            flash[:danger] = "こちらのユーザーはすでに参加、または招待されております"
            redirect_to new_invitation_path(subject_group_id: params[:subject_group_id]) and return
        end

        @subject = Subject.new(subject_name: params[:subject_name], user_id: signup_user.id)
        
        if @subject.save then
            @membership_subject_group = MembershipSubjectGroup.new(
                                            subject_id: @subject.id, 
                                            subject_group_id: params[:subject_group_id])
            if @membership_subject_group.save then
                flash[:success] = "招待しました。" 
                redirect_to subject_group_path(params[:subject_group_id])
            end
        else
        
            @subject.destroy

            @subject_group = SubjectGroup.find(params[:subject_group_id])
            @membership_subject_group = MembershipSubjectGroup.new
            @subject = Subject.new
            flash[:danger] = "招待できませんでした"
            render 'new'
        end

    end


    # POST: /invitations/:id
    # 招待承認処理
    def update
        subject_group = SubjectGroup.find(params[:id])

        # そのグループに招待されていないなら、トップページにリダイレクト
        check_access_invite_subject_group(subject_group)

        user = User.find(params[:user_id])
        # 招待中の所属科目データ
        membership_subject_group = subject_group.belongto_invite_membership_subject_groups(user)

        if membership_subject_group.update(joined_at: (Time.current + 9.hours))
            flash[:success] = "グループに参加しました。" #（success、info、warning、danger）
            redirect_to subject_groups_path
        else
            flash[:danger] = "グループに参加できませんでした。管理者に問い合わせてください。"
            redirect_to subject_group_path(params[:id])
        end

    end

    # DELETE: /invitations/:id
    # 招待削除（取り消し、拒否）、グループ脱退処理
    def destroy
        subject_group = SubjectGroup.find(params[:id])

        # そのグループに所属、もしくは招待されていないなら、トップページにリダイレクト
        check_access_join_invite_subject_group(subject_group)

        user = User.find(params[:user_id])
        subject = subject_group.subject_groups_createuser_subject(user)


        if user.check_access_invite_subject_group(subject_group) then
            membership_subject_group = subject_group.belongto_invite_membership_subject_groups(user)
            membership_subject_group.destroy
            subject.destroy
            flash[:success] = "招待を拒否・キャンセルしました。"
        else
            membership_subject_group = subject_group.belongto_join_membership_subject_groups(user)
            membership_subject_group.destroy
            flash[:success] = "グループを脱退しました。"
        end


        redirect_to subject_groups_path
    end



    # GET: /invitations/user_edit
    # 共有設定変更ページへ
    def user_edit
    end

    # PATCH: /invitations/user_update
    # 共有設定変更処理
    def user_update
        if @user.update(user_invitations_params)
            flash[:success] = "共有設定を変更しました。" #（success、info、warning、danger）
            redirect_to root_url
        else
            # flash[:danger] = "科目内容を変更出来ませんでした。"
            render 'user_edit'
        end
    end


    private

        def user_invitations_params
            params.require(:user).permit(:id, :invite_possible_flag, :invite_user_id)
        end

end
