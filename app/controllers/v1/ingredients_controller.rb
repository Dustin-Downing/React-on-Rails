module V1
  class IngredientsController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show, :create, :update, :destroy]
    before_action :set_recipe
    before_action :set_recipe_ingredient, only: [:show, :update, :destroy]

    # GET /recipes/:recipe_id/ingredients
    def index
      json_response(@recipe.ingredients)
    end

    # GET /recipes/:recipe_id/ingredients/:id
    def show
      json_response(@ingredient)
    end

    # POST /recipes/:recipe_id/ingredients
    def create
      @recipe.ingredients.create!(ingredient_params)
      json_response(@recipe, :created)
    end

    # PUT /recipes/:recipe_id/ingredients/:id
    def update
      @ingredient.update(ingredient_params)
      head :no_content
    end

    # DELETE /recipes/:recipe_id/ingredients/:id
    def destroy
      @ingredient.destroy
      head :no_content
    end

    private

    def ingredient_params
      params.permit(:name, :amount)
    end

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    def set_recipe_ingredient
      @ingredient = @recipe.ingredients.find_by!(id: params[:id]) if @recipe
    end
  end
end
