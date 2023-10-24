class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_area, only: %i[index new create]

  def index
    @articles = @area.articles

  end
  
  def new
    @cities = @area.cities
    @article = Article.new
  end
  
  def create
    @city = City.find(params[:city_id])
    @article = @city.articles.new(article_params.merge(user_id: current_user.id))
    if @article.save
      redirect_to area_articles_path(@area)
    else
      @cities = @area.cities
      render :new
    end
  end
  
  # def show
  #   @article = Article.find(params[:id])
  # end
  
  # def edit
  #   @article = Article.find(params[:id])
  # end
  
  # def update
  #   @article = Article.find(params[:id])
  #   if @article.update(article_params)
  #     redirect_to @article
  #   else
  #     render 'edit'
  #   end
  # end
  
  # def destroy
  #   @article = Article.find(params[:id])
  #   @article.destroy
  #   redirect_to articles_path
  # end
  
  private
  
  def set_area
    @area = Area.find(params[:area_id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :address, photos: [])
  end
end