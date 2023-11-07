class City < ApplicationRecord
  belongs_to :area
  has_many :articles, dependent: :destroy

  private

  def self.ransackable_attributes(auth_object = nil)
  %w[name]
  end
end
