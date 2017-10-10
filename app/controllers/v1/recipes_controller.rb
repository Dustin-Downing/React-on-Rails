module V1
  class RecipesController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show, :create, :update, :destroy]
    before_action :set_recipe, only: [:show, :update, :destroy]

    # GET /recipes
    def index
      # get current recipe todos
      @recipes = Recipe.all.paginate(page: params[:page], per_page: 100)
      json_response(@recipes)
    end

    # GET /recipes/:id
    def show
      render :json => @recipe.to_json(:include => :ingredients)
    end

    # POST recipes/register
    # return authenticated token upon signup
    def create
      @recipe = Recipe.create!(recipe_params)
      params[:ingredients].each do |ingredient|
        @recipe.ingredients.create!(:amount => ingredient[:amount], :name => ingredient[:name])
      end
      json_response(@recipe, :created)
    end

    # PUT /recipes/:id
    def update
      @recipe.update(recipe_params)
      head :no_content
    end

    # DELETE /recipes/:id
    def destroy
      @recipe.destroy
      head :no_content
    end

    private

    def recipe_params
      params.permit(
        :name,
        :description,
        :time,
        :id,
        :ingredients
      )
    end

    def ingredient_params
      params.permit(
        :name,
        :amount
      )
    end


    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
    end
  end
end
