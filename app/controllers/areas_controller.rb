class AreasController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :area_city_choice, only: [:new]

  def top
  end

  def index
  end

  private

  def area_city_choice
    @area = Area.find(params[:id])
    @cities = @area.cities
  end

end
