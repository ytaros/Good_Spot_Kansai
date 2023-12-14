class FavoritesController < ApplicationController
  def create
    @article_favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
    if @article_favorite.save
      render plain: 'Created', status: :ok
    else
      render plain: 'Error', status: :unprocessable_entity
    end
  end

  def destroy
    @article_favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    return unless @article_favorite

    @article_favorite.destroy!
    render plain: 'Destroyed', status: :ok
  end
end
