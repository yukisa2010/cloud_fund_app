require 'rails_helper'

RSpec.describe "Users::Projects", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/users/projects/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/users/projects/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
