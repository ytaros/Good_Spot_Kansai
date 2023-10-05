class User < ApplicationRecord
  belongs_to :prefecture
  has_many :articles
  has_many :favorites
  has_many :favorited_articles, through: :favorites, source: :article
end
