require 'rails_helper'

RSpec.describe "Projects::Investments", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/projects/investments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/projects/investments/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
