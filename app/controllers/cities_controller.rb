class CitiesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_area

  def index
    @cities = @area.cities
  end

  def new
    @city = @area.cities.new
  end

  private

  def set_area
    @area = Area.find(params[:area_id])
  end
end