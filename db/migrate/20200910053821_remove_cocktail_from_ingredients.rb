class RemoveCocktailFromIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_reference :ingredients, :cocktail, null: false, foreign_key: true
  end
end
