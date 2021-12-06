class NewsArticle < ApplicationRecord

    validates :title, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true
    validates :url, presence: true
    validates :image_url, presence: true
    validates :date, presence: true
end
