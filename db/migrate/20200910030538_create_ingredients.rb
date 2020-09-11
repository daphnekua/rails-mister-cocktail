class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.references :cocktail, null: false, foreign_key: true
      t.references :dose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
