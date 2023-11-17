class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  
    def show
      @articles = @user.articles.includes(:user, :category, :photos_attachments, :photos_blob).order(created_at: :desc)
    end
  
    def edit
      @prefectures = Prefecture.all
    end
    
    def update
      if @user.update(user_params)
        redirect_to profile_path, success: t('defaults.message.profile_edited', item: User.model_name.human)
      else
        flash.now['danger'] = t('defaults.message.profile_not_edited', item: User.model_name.human)
        render :edit 
      end
    end
  
    
    private
  
    def set_user
      @user = User.find(current_user.id)
    end  
    
    def user_params
      params.require(:user).permit(:name, :prefecture_id, :email, :avatar, :avatar_cache)
    end
  end