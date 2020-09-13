class Review < ApplicationRecord
  belongs_to :cocktail

  validates :content, :name, presence: true
end
