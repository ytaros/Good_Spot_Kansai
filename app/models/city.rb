class City < ApplicationRecord
  belongs_to :area
  has_many :articles, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
