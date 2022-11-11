require 'rails_helper'

RSpec.describe 'Pets API', type: :request do 
    let!(:user) { create(:user) }
    let!(:pets) { create_list(:pet, 20, user_id: user.id) }
    let(:user_id) { user.id }
    let(:id) { pets.first.id }
    let(:headers) { valid_headers }

    describe 'GET /user/:user_id/pets' do
        before { get "/users/#{user_id}/pets", params: {}, headers: headers } 
    
        context 'when user exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns all user pets' do
                expect(json.size).to eq(20)
            end
        end
    
        context 'when user does not exist' do
            let(:user_id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find User/)
            end
        end
    end
    
    describe 'GET /users/:user_id/pets/:id' do
        before { get "/users/#{user_id}/pets/#{id}", params: {}, headers: headers } 
    
        context 'when user pet exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns the pet' do
                expect(json['id']).to eq(id)
            end
        end
    
        context 'when user pet does not exist' do
            let(:id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Pet/)
            end
        end
    end
    
    describe 'POST /users/:user_id/pets' do
        let(:valid_attributes) { { name: 'John', pet_type: 'dog', breed: 'thing' }.to_json }
    
        context 'when request attributes are valid' do
            before { post "/users/#{user_id}/pets", params: valid_attributes, headers: headers }
    
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end
    
        context 'when an invalid request' do
            before { post "/users/#{user_id}/pets", params: {}, headers: headers }
                
            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
    
            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Pet type can't be blank, Breed can't be blank, Name can't be blank/)
            end
        end
    end
    
    describe 'PUT /users/:user_id/pets/:id' do
        let(:valid_attributes) { { name: "Jackie"}.to_json }
    
        before { put "/users/#{user_id}/pets/#{id}", params: valid_attributes, headers: headers}
    
        context 'when pet exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
    
            it 'updates the pet' do
                updated_pet = Pet.find(id)
                expect(updated_pet.name).to match(/Jackie/)
            end
        end
    
        context 'when the pet does not exist' do
            let(:id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Pet/)
            end
        end
    end
    
    describe 'DELETE /users/:id' do
        before { delete "/users/#{user_id}/pets/#{id}", params: {}, headers: headers }
    
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end