class Area < ApplicationRecord
    has_many :cities, dependent: :destroy
    has_many :articles, dependent: :destroy
end
