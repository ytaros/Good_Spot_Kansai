class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :city
  belongs_to :area
  belongs_to :tag
  has_many :favorites, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 10 }
  validates :address, presence: true
  validates :text, presence: true
  validates :photos, presence: true
  validates :photos, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  size: { less_than: 10.megabytes },
  limit: { min: 1, max: 5 }
  validates :text, presence: true,  length: { maximum: 140 }
  
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  scope :recent, -> { order(created_at: :desc) }
  scope :recent_in_area, ->(area, page) { where(area: area).recent.page(page).per(12) }

  def tag_id=(id)
    self.tag = Tag.find(id)
  end

  def related_data
    {
      area: area,
      cities: area.cities, 
      categories: Category.all,
      tags: Tag.all 
    }
  end 

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  private

  def self.ransackable_attributes(auth_object = nil)
    ["address", "area_id", "category_id", "city_id", "tag_id", "created_at", "id", "text", "title", "updated_at", "user_id"]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[area city tag category]
  end

  def self.related_data(area)
    {
      area: area,
      cities: area.cities, 
      categories: Category.all,
      tags: Tag.all
    }
  end
end
