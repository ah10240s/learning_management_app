class SubjectGroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user


    # GET: /subject_groups
    # 科目一覧ページへ
    def index
        @subject_groups = @user.joining_subject_groups

        @subjecs = @user.joining_subject_group_subjects

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
    end


    # POST: /studyplans
    # 科目追加処理
    def create
        @subject_group = SubjectGroup.new(subject_groups_params)
        @subjects = @user.subjects
        if @subject_group.save
            @membership_subject_group = MembershipSubjectGroup.new(
                subject_id: subject_group_memberships_params[:subject_id], subject_group_id: @subject_group.id, joined_at: DateTime.now)
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


    private


        def subject_groups_params
            params.require(:subject_group).permit(:user_id, :name)
        end

        def subject_group_memberships_params
            params.require(:subject_group).permit(:user_id, :subject_id)
        end

end
