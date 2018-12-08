class QuestionsController < ApplicationController
  before_action :ensure_correct_user, {only: [:edit,  :update]}
  before_action :is_loginned?

  def index
    @questions = Question.all.order(updated_at: "desc")
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(user_id: @current_user.id, title: params[:title], content: params[:content])

    if @question.save
      flash[:notice] = "質問を投稿しました."
    else
      flash[:notice] = "質問の投稿に失敗しました(1)."
    end

    if params[:image]
      image = params[:image]
      @question.image_name = "#{@question.id}.png"
      File.binwrite("public/user_images/#{@question.image_name}", image.read)
    end

    if @question.save
      flash[:notice] = "質問を投稿しました."
      redirect_to("/questions/index")
    else
      flash[:notice] = "質問の投稿に失敗しました(2)."
      render("questions/new")
    end

  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    #@question = Question.find_by(user_id: @current_user.id, title: params[:title], content: params[:content])
    @question = Question.find_by(id: params[:id])
    #@question.user_id = @current_user.id
    @question.title = params[:title]
    @question.content = params[:content]

    if @question.save
      flash[:notice] = "質問を編集しました."
    else
      flash[:notice] = "質問の編集に失敗しました(1)."
    end

    if params[:image]
      image = params[:image]
      @question.image_name = "#{@question.id}.png"
      File.binwrite("public/user_images/#{@question.image_name}", image.read)
    end

    if @question.save
      flash[:notice] = "質問を編集しました."
      redirect_to("/questions/index")
    else
      flash[:notice] = "質問の編集に失敗しました(2)."
      render("questions/new")
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])

    if @question
      @question.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to("/questions/index")
    else
      flash[:notice] = "投稿の削除に失敗しました"
      redirect_to("questions/index")
    end
  end



  def show
    @question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: params[:id]).order(updated_at: "desc")
    @answer = Answer.find_by(user_id: @current_user.id)

    if !@answer
      @answer = Answer.new
    end

  end


  def ensure_correct_user
    question = Question.find_by(id: params[:id].to_i)
    if question
      if @current_user.id != question.user_id
        flash[:notice] = "権限がありません"
        redirect_to("/questions/index")
      end

    else
      flash[:notice] = "質問が存在しません"
      redirect_to("/questions/index")
    end
  end

end
