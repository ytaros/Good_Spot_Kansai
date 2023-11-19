class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Sorcery::Controller
  before_action :set_locale
  before_action :require_login
  before_action :set_search
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_search
    @q = Article.ransack(params[:q])
  end

  def record_not_found
    if Rails.env.production?
      flash[:warning] = t('defaults.message.not_page')
      redirect_to main_top_path
    else
      raise
    end
  end

end
