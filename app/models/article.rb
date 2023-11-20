class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :city
  belongs_to :area
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 10 }
  validates :address, presence: true
  validates :text, presence: true
  validate :has_tags
  validates :category_id, presence: true
  validates :photos, presence: true
  validates :text, presence: true,  length: { maximum: 140 }
  
  def tag_names
    tags.pluck(:name).join(',')
  end

  def tag_names=(names)
    set_tags_by_names(names)
  end

  def has_tags
    errors.add(:tag_names, "を入力してください") if tags.blank?
  end

  def related_data
    {
      area: area,
      cities: area.cities, 
      categories: Category.all,
      tags: tags.pluck(:name) 
    }
  end 

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  private

  def set_tags_by_names(tag_names)
    self.tags = tag_names.split(",").map(&:strip).uniq.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "area_id", "category_id", "city_id", "created_at", "id", "text", "title", "updated_at", "user_id"]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[area city tags category]
  end
end
