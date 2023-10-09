class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Sorcery::Controller
  before_action :set_locale
  before_action :require_login
		

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
