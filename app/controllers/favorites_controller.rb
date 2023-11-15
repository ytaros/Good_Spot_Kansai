class FavoritesController < ApplicationController

  def create
    @article_favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
    @article_favorite.save
    flash[:info] = t('favorite.create')
    redirect_to articles_path(area_id: @article_favorite.article.area_id)
  end

  def destroy
    @article_favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    if @article_favorite
      area_id = @article_favorite.article.area_id
      @article_favorite.destroy
      flash[:info] = t('favorite.destroy')
      redirect_to articles_path(area_id: area_id), status: :see_other
    else
      redirect_to main_top_path, alert: 'Favorite not found', status: :see_other
    end
  end
end