class ArticlesController < ApplicationController
  before_action :set_city

  def index
    @articles = @city.articles
  end
  
  def new
    @article = @city.articles.new
  end
  
  # def create
  #   @article = @city.articles.new(article_params)
  #   if @article.save
  #     redirect_to area_city_articles_path(@city.area, @city)
  #   else
  #     render :new
  #   end
  
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
  
  def set_city
    @city = City.find(params[:city_id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :address)
  end
end