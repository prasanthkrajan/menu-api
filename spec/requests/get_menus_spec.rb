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
    let!(:thin_modern_pizza) { FactoryBot.create(:menu, name: 'Thin Modern Pizza' ) }
    let!(:pan_crust_modern_pizza) { FactoryBot.create(:menu, name: 'Pan Crust Modern Pizza') }
    let!(:thin_classic_pizza) { FactoryBot.create(:menu, name: 'Thin Classic Pizza' ) }
    let!(:pan_crust_classic_pizza) { FactoryBot.create(:menu, name: 'Pan Crust Classic Pizza') }

    context 'and if data that matches the query present' do
      before do
        get "/api/v1/menus?q=classic"
      end

      it 'returns all menus with the name classic, and sorted in ascending order' do
        expect(json.size).to eq(2)
        expect(json[0]['name']).to eq(pan_crust_classic_pizza.name)
        expect(json[1]['name']).to eq(thin_classic_pizza.name)
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

  describe 'GET /index with sorting params' do
    context 'when sorting by price' do
      before do
        FactoryBot.create_list(:menu, 3)
      end

      context 'and in descending order' do
        before do
          get "/api/v1/menus?sort_by=price&order_by=desc"
        end

        it 'returns all menus with price in descending order' do
          expect(json.size).to eq(3)
          expect(json[0]['price']).to be >= (json[1]['price'])
          expect(json[1]['price']).to be >= (json[2]['price'])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'and in ascending order' do
        before do
          get "/api/v1/menus?sort_by=price&order_by=asc"
        end

        it 'returns all menus with price in ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['price']).to be <= (json[1]['price'])
          expect(json[1]['price']).to be <= (json[2]['price'])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'and when order by is not provided' do
        before do
          get "/api/v1/menus?sort_by=price"
        end

        it 'returns all menus with price in default ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['price']).to be <= (json[1]['price'])
          expect(json[1]['price']).to be <= (json[2]['price'])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'when sorting by name' do
      let!(:apple_pizza) { FactoryBot.create(:menu, name: 'Apple Pizza') }
      let!(:banana_pizza) { FactoryBot.create(:menu, name: 'Banana Pizza') }
      let!(:carrot_pizza) { FactoryBot.create(:menu, name: 'Carrot Pizza') }

      context 'and in descending order' do
        before do
          get "/api/v1/menus?sort_by=name&order_by=desc"
        end

        it 'returns all menus with name in descending order' do
          expect(json.size).to eq(3)
          expect(json[0]['name']).to eql(carrot_pizza.name)
          expect(json[1]['name']).to eql(banana_pizza.name)
          expect(json[2]['name']).to eql(apple_pizza.name)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'and in ascending order' do
        before do
          get "/api/v1/menus?sort_by=name&order_by=asc"
        end

        it 'returns all menus with name in asc order' do
          expect(json.size).to eq(3)
          expect(json[0]['name']).to eql(apple_pizza.name)
          expect(json[1]['name']).to eql(banana_pizza.name)
          expect(json[2]['name']).to eql(carrot_pizza.name)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'and when order by is not provided' do
        before do
          get "/api/v1/menus?sort_by=name"
        end

        it 'returns all menus with name in default ascending order' do
          expect(json.size).to eq(3)
          expect(json[0]['name']).to eql(apple_pizza.name)
          expect(json[1]['name']).to eql(banana_pizza.name)
          expect(json[2]['name']).to eql(carrot_pizza.name)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'when sorting by a non-existent attribute' do
      before do
        get "/api/v1/menus?sort_by=random&order_by=asc"
      end

      it 'raises a 422 unprocessable entity error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when ordering by an invalid type' do
      before do
        get "/api/v1/menus?sort_by=price&order_by=random"
      end

      it 'raises a 500 internal server error' do
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end

  describe 'GET /index with search and sorting params' do
    let!(:apple_pizza)     { FactoryBot.create(:menu, name: 'Apple Pizza', price: 15.00) }
    let!(:banana_pizza)    { FactoryBot.create(:menu, name: 'Banana Pizza', price: 25.00) }
    let!(:carrot_pizza)    { FactoryBot.create(:menu, name: 'Carrot Pizza', price: 18.00) }
    let!(:classic_lasagna) { FactoryBot.create(:menu, name: 'Classic Lasagna', price: 10.00) }
    let!(:modern_lasagna)  { FactoryBot.create(:menu, name: 'Modern Lasagna', price: 12.00) }

    context 'and when pizza is searched with descending price' do
      before do
        get "/api/v1/menus?q=pizza&sort_by=price&order_by=desc"
      end

      it 'returns all menus with pizza, sorted in descending price order' do
        expect(json.size).to eq(3)
        expect(json[0]['name']).to eql(banana_pizza.name)
        expect(json[1]['name']).to eql(carrot_pizza.name)
        expect(json[2]['name']).to eql(apple_pizza.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'and when pizza is searched with ascending price' do
      before do
        get "/api/v1/menus?q=pizza&sort_by=price&order_by=asc"
      end

      it 'returns all menus with pizza, sorted in ascending price order' do
        expect(json.size).to eq(3)
        expect(json[0]['name']).to eql(apple_pizza.name)
        expect(json[1]['name']).to eql(carrot_pizza.name)
        expect(json[2]['name']).to eql(banana_pizza.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'and when pizza is searched, sorted by price, but no order provided' do
      before do
        get "/api/v1/menus?q=pizza&sort_by=price"
      end

      it 'returns all menus with pizza, sorted by price, in default ascending order' do
        expect(json.size).to eq(3)
        expect(json[0]['name']).to eql(apple_pizza.name)
        expect(json[1]['name']).to eql(carrot_pizza.name)
        expect(json[2]['name']).to eql(banana_pizza.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'and when pizza is searched, with a descending order, but no sort key provided' do
      before do
        get "/api/v1/menus?q=pizza&order_by=desc"
      end

      it 'returns all menus with pizza, sorted by default sort key; name, in descending order' do
        expect(json.size).to eq(3)
        expect(json[0]['name']).to eql(carrot_pizza.name)
        expect(json[1]['name']).to eql(banana_pizza.name)
        expect(json[2]['name']).to eql(apple_pizza.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end