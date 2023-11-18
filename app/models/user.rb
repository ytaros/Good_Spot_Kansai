class User < ApplicationRecord
  authenticates_with_sorcery!
  belongs_to :prefecture
  has_many :articles,  dependent: :destroy
  has_many :favorites,  dependent: :destroy
  has_many :favorited_articles, through: :favorites, source: :article,  dependent: :destroy

  attr_accessor :password, :password_confirmation

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :prefecture, presence: true

  mount_uploader :avatar, AvatarUploader

  def favorite(article)
    favorite_articles << article
  end

  def unfavorite(article)
    favorite_articles.destroy(article)
  end

  def favorite?(article)
    favorite_articles.include?(article)
  end
end
