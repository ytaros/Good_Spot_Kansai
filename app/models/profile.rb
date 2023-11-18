class Profile < ApplicationRecord
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :prefecture, presence: true
end
