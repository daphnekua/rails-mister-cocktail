class ReviewsController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @review = Review.new(review_params)
    @review.cocktail = @cocktail

    if @review.save
      redirect_to cocktail_path(@cocktail)
    else
      :new
    end
  end

  private

  def find_review
    @cocktail = Cocktail.find(params[cocktail_id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
