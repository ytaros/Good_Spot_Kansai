class Area < ApplicationRecord
    has_many :cities, dependent: :destroy
    has_many :articles, dependent: :destroy

    private

    def self.ransackable_associations(auth_object = nil)
        ["articles", "cities"]
    end

    def self.ransackable_attributes(auth_object = nil)
        %w[name]
    end
end
