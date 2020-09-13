class AddReviewToCocktail < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :content, :string
  end
end
