class UsersController < ApplicationController
  before_action :set_prefectures, only: [:new, :create]
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
    @prefectures = Prefecture.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "新規登録が成功しました"
      redirect_to login_path
    else
      logger.error @user.errors.full_messages.join(', ')
      flash.now[:danger] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :prefecture_id, :email,  :password, :password_confirmation, :avatar,  :avatar_cache)
  end

  def set_prefectures
    @prefectures = Prefecture.all
  end
end
