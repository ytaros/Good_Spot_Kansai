class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_area, only: %i[index new create]
  before_action :set_city, only: [:create]
  before_action :article_find, only: %i[edit update show destroy]
  before_action :set_article, only: %i[edit show]

  def index
    @articles = @area.articles.order(created_at: :desc)
  end
  
  def new
    @cities = @area.cities
    @categories = Category.all
    @article = Article.new
    @tags = ""
  end
  
  def create
    @article = @city.articles.new(article_params.merge(user_id: current_user.id))
    tags = params[:article][:tag_names].split(",").map(&:strip)
    
    if @article.save
      redirect_to area_articles_path(@article.area_id)
    else
      @categories = Category.all
      @cities = City.where(area_id: params[:article][:area_id])
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    if params[:article][:photos].blank? || params[:article][:photos].all?(&:blank?)
      params[:article].delete(:photos)
    end
  
    if @article.update(article_params)
      @article.tag_names = params[:article][:tag_names]
      redirect_to area_articles_path(@article.area_id)
    else
      @area = @article.area
      @cities = @area.cities
      @categories = Category.all
      @tags = @article.tags.pluck(:name).join(',')
      render 'edit'
    end
  end
  
  def show; end
  
  def edit; end
  
  
  def destroy
    @area = @article.area
    @article.destroy!
    redirect_to area_articles_path(@area.id),  status: :see_other
  end

  def search
    @articles = @q.result(distinct: true).includes(:area, :city, :tags, :category).order(created_at: :desc)
  end

  def autocomplete
    term = params[:q]
    results = []
  
    case params[:type]
    when "area_or_city"
      areas = Area.order(:name).where("name LIKE ?", "%#{term}%").limit(5)
      cities = City.order(:name).where("name LIKE ?", "%#{term}%").limit(5)
      render partial: 'autocomplete/area_and_city', locals: { areas: areas, cities: cities }
    when "category"
      categories = Category.order(:name).where("name LIKE ?", "%#{term}%").limit(5)
      render partial: 'autocomplete/categories', locals: { categories: categories }
    when "tag"
      tags = Tag.order(:name).where("name LIKE ?", "%#{term}%").limit(5)
      render partial: 'autocomplete/tags', locals: { tags: tags }
    else
      render json: { error: 'Invalid type' }
    end
  end

  private
  
  def set_area
    @area = Area.find(params[:area_id])
  end

  def set_city
    @city = City.find(params[:article][:city_id])
  end

  def article_find
    @article = Article.find(params[:id])
  end

  def set_article
    @area = @article.area
    @cities = @area.cities
    @categories = Category.all
    @tags = @article.tags.pluck(:name).join(',').presence || ""
  end

  def article_params
    params.require(:article).permit(:title, :text, :address, :category_id, :city_id, :area_id, {photos: []}, :tag_names)
  end
end