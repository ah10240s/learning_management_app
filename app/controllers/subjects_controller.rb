class SubjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_current_user


  # GET: /subjects
  # 科目一覧ページへ
  def index
    @subjects = @user.subjects
  end

  # GET: /subjects/:id
  # 科目詳細ページへ
  def show
  end

  # GET: /subjects/new
  # 科目追加ぺーじへ
  def new
    @subject = Subject.new
    
  end



  # POST: /subjects
  # 科目追加処理
  def create
    @subject = Subject.new(sbject_params)
    if @subject.save
      flash[:success] = "科目を追加しました。" #（success、info、warning、danger）
      redirect_to subjects_path
    else
      # flash[:danger] = "※科目を登録出来ませんでした。"
      render 'new'
    end
  end


  # GET: /subjects/:id/edit
  # 科目編集ページへ
  def edit
    @subject = Subject.find(params[:id])
  end


  # PATCH/PUT: /subjects/:id
  # 科目情報変更処理
  def update
    @subject = Subject.find(params[:id])
    if @subject.update(sbject_params)
      flash[:success] = "科目内容を変更しました。" #（success、info、warning、danger）
      redirect_to subjects_path
    else
      # flash[:danger] = "科目内容を変更出来ませんでした。"
      render 'edit'
    end
  end

  # DELETE: /subjects/:id
  # 科目削除処理
  def destroy
    subject = Subject.find(params[:id])
    subject.destroy
    flash[:success] = "科目を削除しました。"
    redirect_to subjects_path
  end
  

  private


    def sbject_params
      params.require(:subject).permit(:subject_name, :user_id)
    end

end
