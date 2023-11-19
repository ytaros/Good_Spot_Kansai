class CitiesController < ApplicationController
  skip_before_action :require_login, only: %i[new]
  before_action :set_area

  def index
  end

  def new
    @cities = @area.cities
    @city = @area.cities.new
  end

  private

  def set_area
    @area = Area.find(params[:area_id])
  end
end