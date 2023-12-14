class Tag < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :category_tags, dependent: :destroy
  has_many :categories, through: :category_tags, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
