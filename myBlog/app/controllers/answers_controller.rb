class AnswersController < ApplicationController

  def create
    @answer = Answer.new(user_id: params[:user_id], question_id: params[:question_id], content: params[:content])

    if @answer.save
      flash[:notice] = "返信されました！"
      redirect_to("/questions/#{params[:question_id]}/show")
    else
      flash[:notice] = "返信できませんでした"
      render("questions/show")
    end
  end

  def destroy
    @answer = Answer.find_by(user_id: params[:user_id], question_id: params[:question_id])

    if @answer.destroy
      flash[:notice] = "返信を削除しました"
      redirect_to("/questions/#{params[:question_id]}/show")
    else
      flash[:notice] = "返信の削除に失敗しました"
      redirect_to("/questions/index")
    end

  end

end
