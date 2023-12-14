class Area < ApplicationRecord
  has_many :cities, dependent: :destroy
  has_many :articles, dependent: :destroy

  def self.ransackable_associations(_auth_object = nil)
    %w[articles cities]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
