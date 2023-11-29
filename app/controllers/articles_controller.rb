class ArticlesController < ApplicationController
  skip_before_action :require_login, only: %i[index show search autocomplete]
  before_action :set_area, only: %i[index new create]
  before_action :set_city, only: [:create]
  before_action :article_find, only: %i[edit update show destroy]
  before_action :set_article, only: %i[edit show]

  def index
    @articles = @area.articles.includes(:user, :category, :tags, :favorites, :photos_attachments, :photos_blobs).order(created_at: :desc).page(params[:page]).per(2)
  end

  def user_articles
    @articles = current_user.articles.includes(:category, :tags, :favorites).order(created_at: :desc)

    respond_to do |format|
      format.json { render json: @articles }
    end
  end
  
  def new
    @cities = @area.cities
    @categories = Category.all
    @article = Article.new
    @tags = ""
  end
  
  def create
    @city = City.find_by(id: params[:article][:city_id])
  
    @article = if @city
                @city.articles.new(article_params.merge(user_id: current_user.id))
              else
                Article.new(article_params)
              end
    tags = params[:article][:tag_names].split(",").map(&:strip)
  
    if @article.save
      flash[:success] = t('.create')
      redirect_to area_articles_path(@article.area_id)
    else
      load_supporting_data
      flash.now[:error] = @article.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end
  

  def update
    if params[:article][:photos].blank? || params[:article][:photos].all?(&:blank?)
      params[:article].delete(:photos)
    end
  
    if @article.update(article_params)
      @article.tag_names = params[:article][:tag_names]
      flash[:success] = I18n.t("defaults.message.updated", item: "記事")
      redirect_to area_articles_path(@article.area_id)
    else
      load_supporting_data
      @tags = @article.tags.pluck(:name).join(',')
      flash.now[:error] = @article.errors.full_messages.join(', ')
      render 'edit', status: :unprocessable_entity
    end
  end
  
  def show
    @area_id = @article.area.id
  end
  
  def edit; end
  
  
  def destroy
    @area = @article.area
    @article.destroy!
    flash[:success] = I18n.t("defaults.message.deleted", item: "投稿")
    redirect_to area_articles_path(@area.id), status: :see_other
  end

  def search
    @articles = @q.result(distinct: true).includes(:user, :area, :city, :tags, :category, photos_attachments: :blob).order(created_at: :desc)
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

  def favorites
    @favorite_articles = current_user.favorited_articles.includes(:user, :category, :tags, photos_attachments: :blob).order(created_at: :desc)
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

  def article_params
    params.require(:article).permit(:title, :text, :address, :category_id, :city_id, :area_id, {photos: []}, :tag_names)
  end


  def load_supporting_data
    @categories = Category.all
    @cities = City.where(area_id: params[:article][:area_id])
  end
end