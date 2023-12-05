class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[for_category]
  def for_category
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      tags = category.tags
    else
      tags = Tag.all
    end

    render json: tags
  end
end
