class StudyplansController < ApplicationController
    before_action :authenticate_user!
    before_action :set_current_user


    # GET: /studyplans
    # 科目一覧ページへ
    def index
        @studyplans = @user.studyplans
    end

    # GET: /studyplans/:id
    # 科目詳細ページへ
    def show
    end

    
    # GET: /studyplans/new
    # 学習予定追加ぺーじへ
    def new
        @subjects = @user.subjects
        @studyplan = Studyplan.new
    end

    # POST: /studyplans
    # 科目追加処理
    def create
        @studyplan = Studyplan.new(studyplans_params)
        @subjects = @user.subjects
        if @studyplan.save
            flash[:success] = "科目を追加しました。" #（success、info、warning、danger）
            redirect_to studyplans_path
        else
            # flash[:danger] = "科目を登録出来ませんでした。"
            render 'new'
        end
    end


    # GET: /studyplans/:id/edit
    # 科目編集ページへ
    def edit
        @studyplan = Studyplan.find(params[:id])
        @subject = Subject.find(@studyplan.subject_id)
    end


    # PATCH/PUT: /studyplans/:id
    # 科目情報変更処理
    def update
        @studyplan = Studyplan.find(params[:id])
        @subject = Subject.find(@studyplan.subject_id)
        if @studyplan.update(studyplans_params)
            flash[:success] = "科目内容を変更しました。" #（success、info、warning、danger）
            redirect_to studyplans_path
        else
            # flash[:danger] = "科目内容を変更出来ませんでした。"
            render 'edit'
        end
    end

    # DELETE: /studyplans/:id
    # 科目削除処理
    def destroy
        studyplan = Studyplan.find(params[:id])
        studyplan.destroy
        flash[:success] = "科目を削除しました。"
        redirect_to studyplans_path
    end


    def complete
        @studyplan = Studyplan.find(params[:id])
        @studyplan.done_flag = true
        @studyplan.save
        # redirect_to studyplans_path
        respond_to do |format|
            format.html { redirect_to studyplans_path }
            format.js
        end
    end


    def incomplete
        @studyplan = Studyplan.find(params[:id])
        @studyplan.done_flag = false
        @studyplan.save
        # redirect_to studyplans_path
        respond_to do |format|
            format.html { redirect_to studyplans_path }
            format.js
        end
    end

    private


        def studyplans_params
            params.require(:studyplan).permit(:user_id, :subject_id, :start_daytime, :end_daytime, :done_flag)
        end


end
