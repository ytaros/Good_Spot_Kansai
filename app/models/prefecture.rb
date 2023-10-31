class Prefecture < ApplicationRecord
  has_many :users, dependent: :destroy
end
