class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :create]
  before_action :set_ingredients, only: [:new, :create]

  def index

  end

  def show

  end

  def new
    # @ingredients = @ingredients.map { |i| i.name }
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    @dose.save

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def set_ingredients
    @ingredients = Ingredient.all
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
