class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :city
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :favorites
end
