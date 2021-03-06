class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :edit, :destroy]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @doses = @cocktail.doses

    # @ingredients = Ingredient.all
    @dose = Dose.new
    # @dose.cocktail = @cocktail

    @review = Review.new
    # @review.cocktail = @cocktail
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @ingredients = Ingredient.all

    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)

    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail.destroy

    redirect_to cocktails_path
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
