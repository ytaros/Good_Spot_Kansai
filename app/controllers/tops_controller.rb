class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[top index]
  include BackgroundImagesConcern
  before_action :set_background_images, only: [:top]
  
  def top;end
  
  def index;end
end
