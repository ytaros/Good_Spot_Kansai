class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :city
  belongs_to :area
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :photos, dependent: :destroy

  validates :title, presence: true
  validates :address, presence: true
  validates :text, presence: true
  validate :has_tags
  validates :category_id, presence: true
  
  def tag_names
    tags.pluck(:name).join(',')
  end

  def tag_names=(names)
    set_tags_by_names(names)
  end

  def has_tags
    errors.add(:tag_names, "を入力してください") if tags.blank?
  end

  private

  def set_tags_by_names(tag_names)
    self.tags = tag_names.split(",").map(&:strip).uniq.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end
end
