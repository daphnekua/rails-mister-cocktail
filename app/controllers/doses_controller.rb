class DosesController < ApplicationController
  before_action :dose_params, only: [:destroy]

  def index
    @doses = Dose.all
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      :new
    end

    def destroy
      @dose.destroy

      redirect_to cocktail_path(@dose.cocktail)
    end

  end

  private

  def find_dose
    @dose = Dose.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end