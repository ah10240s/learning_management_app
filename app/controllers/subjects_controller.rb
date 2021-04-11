class SubjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_current_user, only: [:new, :index]

  # GET: /subjects/new
  # 科目追加ぺーじへ
  def new
    @subject = Subject.new
    
  end

  # GET: /subjects
  # 科目一覧ページへ
  def index
    @subjects = @user.subjects
  end

  # POST: /subjects
  # 科目追加処理
  def create
    @subject = Subject.new(sbject_params)
    if @subject.save
      flash[:success] = "科目を追加しました。" #（success、info、warning、danger）
      redirect_to subjects_path
    else
      flash[:danger] = "科目を登録出来ませんでした。"
      render 'new'
    end
  end

  private


    def sbject_params
      params.require(:subject).permit(:subject_name, :user_id)
    end

end
