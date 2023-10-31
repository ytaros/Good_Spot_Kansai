class Tag < ApplicationRecord
  has_many :article_tags,  dependent: :destroy
  has_many :articles, through: :article_tags, dependent: :destroy
end
