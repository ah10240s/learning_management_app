class SubjectGroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user
# 

    # GET: /subject_groups
    # グループ一覧ページへ
    def index
        # 科目グループに参加中の科目一覧
        @subjecs = @user.joining_subject_group_subjects
        # 招待を受けている科目グループ一覧
        @subject_groups = @user.inviting_subject_groups
        
    end


    # GET: /subject_groups/new
    # グループ作成ぺーじへ
    def new
        @subjects = @user.not_joining_subject_group_subjects
        @subject_group = SubjectGroup.new
        @membership_subject_group = MembershipSubjectGroup.new
    end

    # GET: /subject_groups/:id
    # グループ詳細ページへ
    def show
        @subject_group = SubjectGroup.find(params[:id])

        # そのグループに所属、もしくは招待されていないなら、トップページにリダイレクト
        check_access_join_invite_subject_group(@subject_group)

        @subject = @subject_group.subject_groups_createuser_subject(@user)
        @join_users = @subject_group.subject_groups_joining_notcreate_users
        @create_user = @subject_group.user
        @invite_users = @subject_group.subject_groups_inviting_users
    end


    # POST: /subject_groups
    # グループ追加処理
    def create
        @subject_group = SubjectGroup.new(subject_groups_params)
        @subjects = @user.notinvite_subjects
        if @subject_group.save
            @membership_subject_group = MembershipSubjectGroup.new(
                subject_id: subject_group_memberships_params[:subject_id], subject_group_id: @subject_group.id, joined_at: Time.current)
            if @membership_subject_group.save
                flash[:success] = "グループを作成しました。" #（success、info、warning、danger）
                redirect_to subject_groups_path
            else
                @subject_group.destroy
                render 'new'
            end
        else
            # flash[:danger] = "科目を登録出来ませんでした。"
            render 'new'
        end
    end


    # GET: /subject_groups/:id/edit
    # グループ編集ページへ
    def edit
        @subject_group = SubjectGroup.find(params[:id])
        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(@subject_group)
    end


    # PATCH/PUT: /subject_groups/:id
    # グループ名情報変更処理
    def update
        @subject_group = SubjectGroup.find(params[:id])
        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(@subject_group)
        if @subject_group.update(subject_group_name_params)
            flash[:success] = "グループ名を変更しました。" #（success、info、warning、danger）
            redirect_to subject_group_path
        else
            # flash[:danger] = "科目内容を変更出来ませんでした。"
            render 'edit'
        end
    end


    # DELETE: /subject_groups/:id
    # グループ削除処理
    def destroy
        # 科目グループ削除
        # 所属データ削除
        # 招待中の場合は、科目も削除

        subject_group = SubjectGroup.find(params[:id])
        # そのグループに所属していないなら、トップページにリダイレクト(アクセス制限)
        check_access_join_subject_group(subject_group)

        subjects = subject_group.belongto_invite_alluser_subjects

        subject_group.destroy

        subjects.each do |subject|
            subject.destroy
        end

        flash[:success] = "グループを削除しました"

        redirect_to subject_groups_path
    end

    private


        def subject_groups_params
            params.require(:subject_group).permit(:user_id, :name)
        end

        def subject_group_memberships_params
            params.require(:subject_group).permit(:user_id, :subject_id)
        end

        def subject_group_name_params
            params.require(:subject_group).permit(:name)
        end

end
