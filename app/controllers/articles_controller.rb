class ArticlesController < ApplicationController
  include SupportingData
  skip_before_action :require_login, only: %i[index show search autocomplete ranking]

  def index
    @articles = Article.recent_in_area(@area, params[:page]).includes(:user, :category, :city, :area, :tag, :favorites, photos_attachments: :blob)
  end

  def new
    @article = Article.new
    @supporting_data = Article.related_data(@area)
    @cities = @supporting_data[:cities]
    @tags = @supporting_data[:tags]
  end

  def create
    @article = current_user.articles.build(article_params)
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
    params[:article].delete(:photos) if params[:article][:photos].blank? || params[:article][:photos].all?(&:blank?)

    if @article.update(article_params)
      flash[:success] = I18n.t('defaults.message.updated', item: '記事')
      redirect_to area_articles_path(@article.area_id)
    else
      load_supporting_data
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
    flash[:success] = I18n.t('defaults.message.deleted', item: '投稿')
    redirect_to area_articles_path(@area.id), status: :see_other
  end

  def search
    @articles = @q.result(distinct: true)
                  .includes(:user, :area, :city, :tag, :category, photos_attachments: :blob)
                  .recent
                  .page(params[:page]).per(8)
  end

  def autocomplete
    term = params[:q]
    case params[:type]
    when 'area_or_city'
      areas = Area.order(:name).where('name LIKE ?', "%#{term}%").limit(5)
      cities = City.order(:name).where('name LIKE ?', "%#{term}%").limit(5)
      render partial: 'autocomplete/area_and_city', locals: { areas:, cities: }
    else
      render json: { error: 'Invalid type' }
    end
  end

  def favorites
    @favorite_articles = current_user.favorited_articles.includes(:user, :category, :tag,
                                                                  photos_attachments: :blob).order(created_at: :desc)
                                                                  .page(params[:page]).per(8)
  end

  def ranking
    @articles = Article.joins(:favorites).select('articles.*, COUNT(favorites.id) as favorites_count')
                       .group('articles.id')
                       .order('favorites_count DESC')
                       .page(params[:page]).per(10)
  end

  def recommend
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'

    latitude = params[:latitude] ? params[:latitude].to_f : 34.702485
    longitude = params[:longitude] ? params[:longitude].to_f : 135.495951

    @articles = Article.near([latitude, longitude], 30)
    articles_json = @articles.map do |article|
      article.as_json(include: %i[tag category city]).merge({
                                                              photos: article.photos.map do |photo|
                                                                rails_blob_path(photo, only_path: true)
                                                              end
                                                            })
    end

    respond_to do |format|
      format.html
      format.json { render json: articles_json }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :address, :category_id, :city_id, :area_id, :tag_id, { photos: [] })
  end
end
