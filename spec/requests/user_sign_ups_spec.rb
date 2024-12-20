# spec/requests/user_sign_up_spec.rb
require 'rails_helper'

RSpec.describe 'UserSignUps', type: :request do
  describe 'GET /users/sign_up' do
    it 'renders the sign-up page' do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Sign up')
    end
  end

  describe 'POST /users/sign_up' do
    context 'with valid parameters' do
      it 'creates a new user and redirects to the home page' do
        post user_registration_path, params: { user: { email: 'user@example.com', password: 'password123', password_confirmation: 'password123' } }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Welcome! You have signed up successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a user and renders the sign-up page again' do
        post user_registration_path, params: { user: { email: '', password: 'password123', password_confirmation: 'password123' } }
        
        expect(response).to have_http_status(:unprocessable_entity)  # Expecting the page to reload with errors
        expect(response.body).to include('Sign up')  # Check that the page includes the word "Sign up"
        
        # Check if the error message for the email is displayed in the HTML response
        expect(response.body).to include('Email can&#39;t be blank')  # HTML encoding for single quote
      end
    end
  end
end
