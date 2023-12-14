class CategoriesController < ApplicationController
  skip_before_action :require_login, only: %i[tags]
  def tags
    category = Category.find(params[:id])
    tags = category.tags.select(:id, :name)
    render json: tags
  end
end
