require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'GET /index' do
    context 'and if data is present' do
      before do
        FactoryBot.create_list(:menu, 10)
        get '/api/v1/menus'
      end
      
      it 'returns all menus' do
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'but if no data is present' do
      before do
        get '/api/v1/menus'
      end
      
      it 'returns no menu' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /index with search params' do
    before do
      FactoryBot.create_list(:menu, 5, name: 'Classic Pizza')
      FactoryBot.create_list(:menu, 5, name: 'Modern Pizza')
    end

    context 'and if data that matches the query present' do
      before do
        get "/api/v1/menus?q=classic"
      end

      it 'returns all menus with the name classic' do
        expect(json.size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'and if data does not match the query present' do
      before do
        get "/api/v1/menus?q=random"
      end

      it 'returns no menu' do
        expect(json.size).to eq(0)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end