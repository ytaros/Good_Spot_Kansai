class Tag < ApplicationRecord
  has_many :article_tags,  dependent: :destroy
  has_many :articles, through: :article_tags, dependent: :destroy

  private

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
