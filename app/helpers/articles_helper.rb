module ArticlesHelper
  def favorite_for(article, user)
    article.favorites.detect { |favorite| favorite.user_id == user.id }
  end
end
