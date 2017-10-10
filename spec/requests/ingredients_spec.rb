require 'rails_helper'

RSpec.describe 'Ingredients API' do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe) }
  let!(:ingredients) { create_list(:ingredient, 20, recipe_id: recipe.id) }
  let(:recipe_id) { recipe.id }
  let(:id) { ingredients.first.id }
  let(:headers) { valid_headers }

  describe 'GET /recipes/:recipe_id/ingredients' do
    before { get "/recipes/#{recipe_id}/ingredients", params: {}, headers: headers }

    context 'when recipe exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all recipe ingredients' do
        expect(json.size).to eq(20)
      end
    end

    context 'when recipe does not exist' do
      let(:recipe_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  describe 'GET /recipes/:recipe_id/ingredients/:id' do
    before { get "/recipes/#{recipe_id}/ingredients/#{id}", params: {}, headers: headers }

    context 'when recipe ingredient exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the ingredient' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when recipe ingredient does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  describe 'POST /recipes/:recipe_id/ingredients' do
    let(:valid_attributes) do
     # send json payload
     { name: 'Visit Narnia', amount: "some number" }.to_json
   end

    context 'when request attributes are valid' do
      before do
        post "/recipes/#{recipe_id}/ingredients", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/recipes/#{recipe_id}/ingredients", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /recipes/:recipe_id/ingredients/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }

    before do
      put "/recipes/#{recipe_id}/ingredients/#{id}", params: valid_attributes, headers: headers
    end

    context 'when ingredient exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the ingredient' do
        updated_ingredient = Ingredient.find(id)
        expect(updated_ingredient.name).to match(/Mozart/)
      end
    end

    context 'when ingredient does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  describe 'DELETE /recipes/:id' do
    before { delete "/recipes/#{recipe_id}/ingredients/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
