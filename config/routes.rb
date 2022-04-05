# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todos
      scope :todos do
        patch ':id/update_status' => 'todos#update_status', as: :update_status
      end
    end
  end
  devise_for :users, class_name: 'Api::V1::User',
                     controllers: {
                       sessions: 'api/v1/users/sessions',
                       registrations: 'api/v1/users/registrations'
                     }
end
