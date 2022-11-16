require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do 
    let(:user) { create(:user) }
    let!(:pets) { create(:pet, user_id: user.id) }
    let!(:appointments) { create_list(:appointment, 20, pet_id: pets.id) }
    let(:user_id) { user.id }
    let(:pet_id) { pets.id }
    let(:id) { appointments.first.id }
    let(:headers) { valid_headers }
    
    describe 'POST /users/:user_id/pets/:pet_id/appointments' do
        let(:valid_attributes) { { date: 2010-06-31, time: "'09:00" }.to_json }
    
        context 'when request attributes are valid' do
            before { post "/users/#{user_id}/pets/#{pet_id}/appointments", params: valid_attributes, headers: headers}
    
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end
    
        context 'when an invalid request' do
            before { post "/users/#{user_id}/pets/#{pet_id}/appointments", params: {}, headers: headers }
                
            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
    
            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Date can't be blank, Time can't be blank/)
            end
        end
    end
    
end