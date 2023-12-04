module SupportingData
  extend ActiveSupport::Concern

  included do
    before_action :set_area, only: %i[index new create]
    before_action :set_city, only: [:create]
    before_action :article_find, only: %i[edit update show destroy]
    before_action :set_article, only: %i[edit show]
  end

  private

  def set_area
    @area = Area.find_by(id: params[:area_id])
  end

  def set_city
    @city = City.find_by(id: params[:article][:city_id])
  end

  def article_find
    @article = Article.find_by(id: params[:id])
  end

  def set_article
    @area = @article.area
    @cities = @area.cities
    @categories = Category.all
    @tags = @article.tags.pluck(:name).join(',').presence || ""
  end

  def load_supporting_data
    @categories = Category.all
    @cities = City.where(area_id: params[:article][:area_id])
  end
end