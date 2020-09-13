class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo
  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
end
