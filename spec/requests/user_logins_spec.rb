# spec/requests/user_logins_spec.rb

RSpec.describe "UserLogins", type: :request do
  describe "POST /users/sign_in with valid credentials" do
# spec/requests/user_logins_spec.rb
it "logs in the user and redirects to the dashboard or home page" do
  user = FactoryBot.create(:user, email: "tester@tester.com", password: "password")
  post user_session_path, params: { user: { email: user.email, password: user.password } }

  expect(response).to have_http_status(:see_other) # or expect(response.status).to eq(303)
  # Further checks for the redirection URL can also be added here
end
  end

  describe "POST /users/sign_in with invalid credentials" do
    it 'does not log in the user and re-renders the login page' do
      post user_session_path, params: { user: { email: 'invalid@example.com', password: 'wrongpassword' } }
    
      # Ensure that the login page is re-rendered
      expect(response).to render_template(:new)
    
      # Ensure that no user is logged in (this step depends on your authentication logic)
      expect(controller.current_user).to be_nil
    end    
  end
end
