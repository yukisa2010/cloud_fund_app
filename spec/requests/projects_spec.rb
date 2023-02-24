require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let!(:project) { create(:project) }

  describe 'GET /projects' do
    it 'アクセスできること' do
      get projects_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /projects/:id' do
    it 'アクセスできること' do
      get project_path(project)
      expect(response).to have_http_status(200)
    end
  end
end
