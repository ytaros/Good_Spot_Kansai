class City < ApplicationRecord
  belongs_to :area
  has_many :articles
end
