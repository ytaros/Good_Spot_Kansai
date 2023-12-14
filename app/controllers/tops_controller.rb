class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[top index privacy_policy terms_of_service]
  skip_before_action :set_search, only: %i[top]
  include BackgroundImagesConcern
  before_action :set_background_images, only: [:top]

  def top; end

  def index; end

  def privacy_policy; end

  def terms_of_service; end
end
