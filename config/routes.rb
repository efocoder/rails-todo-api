# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

    end
  end
  devise_for :users, class_name: 'Api::V1::User',
                     controllers: {
                       sessions: 'api/v1/users/sessions',
                       registrations: 'api/v1/users/registrations'
                     }
end
