class UsersController < ApplicationController
  before_action :is_loginned?, {only: [:show, :logout, :edit, :update]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_name: params[:user_name], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "新規登録に成功しました."
      redirect_to("/")
    else
      flash[:notice] = "新規登録に失敗しました."
      render("users/new")
    end

  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(user_name: params[:user_name])

    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインに成功しました."
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @user = User.new(user_name: params[:user_name], password: params[:password])
      flash[:notice] = "ログインに失敗しました."
      render("users/login_form")
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user
      @user.user_name = params[:user_name]
      @user.year = params[:year].to_i
      @user.month = params[:month].to_i
      @user.day = params[:day].to_i
      @user.prefectures = params[:prefectures]
      @user.enthusiasm = params[:enthusiasm]
    end

    if @user.save
      flash[:notice] = "ユーザ情報を編集しました."
      redirect_to("/users/#{@user.id}/show")
    else
      flash[:notice] = "編集に失敗しました."
      render("users/edit")
    end

  end


  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
