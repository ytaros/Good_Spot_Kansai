class City < ApplicationRecord
  belongs_to :area
  has_many :articles, dependent: :destroy
end
