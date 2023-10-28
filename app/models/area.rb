class Area < ApplicationRecord
    has_many :cities
    has_many :articles
end
