# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Todo, type: :request do
  let(:valid_attributes) { attributes_for(:api_v1_todo) }
  let(:invalid_attributes) { attributes_for(:api_v1_todo, title: nil, user: nil) }
  let(:empty_body) {}
  let(:valid_headers) do
    {}
  end


  describe 'GET /index' do
    it 'renders a successful response' do
      Api::V1::Todo.create! valid_attributes
      get api_v1_todos_url, headers: auth_header(valid_attributes[:user])

      expect(response).to be_successful
      expect(response.content_type).to match 'application/json'
      expect(json_body(response).class).to be Hash
      expect(json_body(response)['status_code']).to be 200
      expect(json_body(response)['data'].class).to be Array
      expect(json_body(response)['data'].length).to be 1
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      todo = Api::V1::Todo.create! valid_attributes
      get api_v1_todo_url(todo), headers: auth_header(valid_attributes[:user])

      expect(response).to be_successful
      expect(response.content_type).to match 'application/json'
      expect(json_body(response).class).to be Hash
      expect(json_body(response)['status_code']).to be 200
      expect(json_body(response)['data'].class).to be Array
      expect(json_body(response)['data'].length).to be 1
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Api::V1::Todo' do

        post api_v1_todos_url, params: { todo: valid_attributes }, headers: auth_header(valid_attributes[:user])

        expect(response).to have_http_status(:created)
        expect { response }.to change(Api::V1::Todo, :count).by_at_most(1)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response).class).to be Hash
        expect(json_body(response)['status_code']).to be 201
        expect(json_body(response)['data'].class).to be Array
        expect(json_body(response)['data'].length).to be 1
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Api::V1::Todo' do
        post api_v1_todos_url, params: { todo: invalid_attributes }, headers: auth_header(valid_attributes[:user])
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response).class).to be Hash
        expect { response }.to change(Api::V1::Todo, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:api_v1_todo, description: Faker::Lorem.paragraph, status: 'COMPLETED') }

      it 'updates the requested api_v1_todo' do
        todo = Api::V1::Todo.create! valid_attributes
        patch api_v1_todo_url(todo), params: { todo: new_attributes }, headers: auth_header(valid_attributes[:user])
        todo.reload

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response)['status_code']).to be 200
        expect(json_body(response)['data'].class).to be Array
        expect(todo.status).to eq new_attributes[:status]
        expect(todo.description).to eq new_attributes[:description]
      end

      it 'updates the todo status' do
        todo = Api::V1::Todo.create! valid_attributes
        patch api_v1_update_status_url(todo), params: { status: 'COMPLETED' },
                                              headers: auth_header(valid_attributes[:user])
        todo.reload
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response)['status_code']).to be 200
        expect(json_body(response)['data'].class).to be Array
        expect(todo.status).to eq 'COMPLETED'

      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the api_v1_todo' do
        todo = Api::V1::Todo.create! valid_attributes
        patch api_v1_todo_url(todo), params: { todo: invalid_attributes }, headers: auth_header(valid_attributes[:user])
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response).class).to be Hash
      end

      it 'does not updates status' do
        todo = Api::V1::Todo.create! valid_attributes
        patch api_v1_update_status_url(todo), params: { status: 'DUMMY' },
                                              headers: auth_header(valid_attributes[:user])
        todo.reload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response).class).to be Hash
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested api_v1_todo' do
      todo = Api::V1::Todo.create! valid_attributes
      delete api_v1_todo_url(todo), headers: auth_header(valid_attributes[:user])
      todo.reload
      expect(json_body(response)['status_code']).to be 200
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to match 'application/json'
      expect(json_body(response)['data'].class).to be Array
      expect(todo.status).to eq 'DELETED'
    end
  end
end
