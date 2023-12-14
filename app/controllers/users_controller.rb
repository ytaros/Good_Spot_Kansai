class UsersController < ApplicationController
  before_action :set_prefectures, only: %i[new create]
  before_action :require_no_login, only: [:new, :create]
  skip_before_action :require_login, only: %i[new create]


  def new
    @user = User.new
    @prefectures = Prefecture.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] =  I18n.t("defaults.message.created", item: "User")
      redirect_to main_top_path
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render 'new', status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :prefecture_id, :email,  :password, :password_confirmation, :avatar,  :avatar_cache)
  end

  def set_prefectures
    @prefectures = Prefecture.all
  end

  def require_no_login
    redirect_to main_top_path if logged_in?
  end
end
