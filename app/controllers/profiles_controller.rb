class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :set_prefectures, only: %i[edit update show]

  def show
    @articles = @user.articles.includes(:category, :city).order(created_at: :desc).page(params[:page]).per(8)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t('defaults.message.profile_edited')
      redirect_to profile_path
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      reset_session
      redirect_to root_path, status: :see_other
    else
      flash[:error] = I18n.t('defaults.message.not_deleted', item: 'User')
      redirect_to profile_path
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_prefectures
    @prefectures = Prefecture.all
  end

  def user_params
    params.require(:user).permit(:name, :prefecture_id, :email, :avatar, :avatar_cache)
  end
end
