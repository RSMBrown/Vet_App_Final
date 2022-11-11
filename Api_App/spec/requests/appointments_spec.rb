require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do 
    let(:user) { create(:user) }
    let!(:pets) { create(:pet, user_id: user.id) }
    let!(:appointments) { create_list(:appointment, 20, pet_id: pets.id) }
    let(:user_id) { user.id }
    let(:pet_id) { pets.id }
    let(:id) { appointments.first.id }
    let(:headers) { valid_headers }

    describe 'GET /users/:user_id/pets/:pet_id/appointments' do
        before { get "/users/#{user_id}/pets/#{pet_id}/appointments", params: {}, headers: headers  }
    
        context 'when pet exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns all pet items' do
                expect(json.size).to eq(20)
            end
        end
    
        context 'when pet does not exist' do
            let(:pet_id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Pet/)
            end
        end
    end
    
    describe 'GET /users/:user_id/pets/:pet_id/appointments/:id' do
        before { get "/users/#{user_id}/pets/#{pet_id}/appointments/#{id}", params: {}, headers: headers  }
    
        context 'when pet appointment exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
    
            it 'returns the appointment' do
                expect(json['id']).to eq(id)
            end
        end
    
        context 'when pet appointment does not exist' do
            let(:id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Appointment/)
            end
        end
    end
    
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
    
    describe 'PUT /users/:user_id/pets/:pet_id/appointments/:id' do
        let(:valid_attributes) { { date: 2010-06-31, time: "09:00" }.to_json }
    
        before { put "/users/#{user_id}/pets/#{pet_id}/appointments/#{id}", params: valid_attributes, headers: headers }
    
        context 'when appointment exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
    
            it 'updates the appointment' do
                updated_appointment = Appointment.find(id)
                expect(updated_appointment.time).to match(/09:00/)
            end
        end
    
        context 'when the appointment does not exist' do
            let(:id) { 0 }
    
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
    
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Appointment/)
            end
        end
    end
    
    describe 'DELETE /users/:user_id/pets/:id' do
        before { delete "/users/#{user_id}/pets/#{pet_id}/appointments/#{id}", params: {}, headers: headers  }
    
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end