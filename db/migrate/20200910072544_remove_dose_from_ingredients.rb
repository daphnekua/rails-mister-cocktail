class RemoveDoseFromIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_reference :ingredients, :dose, null: false, foreign_key: true
  end
end
