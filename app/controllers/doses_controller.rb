class DosesController < ApplicationController
  before_action :find_dose, only: [:destroy]

  def index
    @cocktail = Cocktail.find(params[:cocktail_id])
    @doses = @cocktail.doses
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      :new
    end
  end

  def destroy
    @dose.destroy

    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def find_dose
    @dose = Dose.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
