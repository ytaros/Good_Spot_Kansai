class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :set_prefectures, only: %i[edit update show]
  
    def show
      @articles = @user.articles.includes(:category, :photos_attachments, :photos_blob, :prefecture, :city).order(created_at: :desc)
    end
  
  
    def edit; end
    
    def update
      if @user.update(user_params)
        redirect_to profile_path, success: t('defaults.message.profile_edited', item: User.model_name.human)
      else
        flash.now[:error] = @user.errors.full_messages.join(', ')
        render :edit, status: :unprocessable_entity
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