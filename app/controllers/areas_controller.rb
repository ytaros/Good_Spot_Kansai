class AreasController < ApplicationController
  skip_before_action :require_login, only: %i[index]

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
