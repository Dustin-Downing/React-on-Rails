require 'rails_helper'

RSpec.describe 'Recipes API', type: :request do
  let(:user) { create(:user) }
  let!(:recipes) { create_list(:recipe, 10) }
  let(:recipe_id) { recipes.first.id }
  let(:headers) { valid_headers }

  describe 'GET /recipes' do
    # update request with headers
    before { get '/recipes', params: {}, headers: headers }

    it 'returns recipes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /recipes/:id' do
    before { get "/recipes/#{recipe_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the recipe' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(recipe_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:recipe_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  describe 'POST /recipes' do
     let(:valid_attributes) do
      # send json payload
      { name: 'Test Recipe', description: "Lucas ipsum", time: Random.rand(100) }.to_json
    end

    context 'when request is valid' do
      before { post '/recipes', params: valid_attributes, headers: headers }

      it 'creates a recipe' do
        expect(json['name']).to eq('Test Recipe')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      let(:valid_attributes) { { name: nil, description: nil, time: nil }.to_json }
      before { post '/recipes', params: valid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank, Description can't be blank, Time can't be blank/)
      end
    end
  end

  describe 'PUT /recipes/:id' do
    let(:valid_attributes) { { title: 'Recipe single' }.to_json }

    context 'when the record exists' do
      before { put "/recipes/#{recipe_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /recipes/:id' do
    before { delete "/recipes/#{recipe_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
