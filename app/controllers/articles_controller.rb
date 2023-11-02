class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_area, only: %i[index new create]
  before_action :set_city, only: [:create]

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
      logger.debug @article.errors.full_messages
      @categories = Category.all
      @cities = City.where(area_id: params[:article][:area_id])
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    @article = Article.find(params[:id])
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
  
  def show
    @article = Article.find(params[:id])
    @area = @article.area
    @cities = @area.cities
    @categories = Category.all
    @tags = @article.tags.pluck(:name).join(',')
  end
  
  def edit
    @article = Article.find(params[:id])
    @area = @article.area
    @cities = @area.cities
    @categories = Category.all
    @tags = @article.tags.pluck(:name).join(',')
  end
  
  
  def destroy
    @article = Article.find(params[:id])
    @area = @article.area
    @article.destroy!
    redirect_to area_articles_path(@area.id),  status: :see_other
  end
  
  private
  
  def set_area
    @area = Area.find(params[:area_id])
  end

  def set_city
    @city = City.find(params[:article][:city_id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :address, :category_id, :city_id, :area_id, {photos: []}, :tag_names)
  end
end