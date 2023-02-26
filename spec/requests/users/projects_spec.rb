require 'rails_helper'

RSpec.describe 'Users::Projects', type: :request do
  let(:user) { create(:user, status: :normal) }

  before { sign_in user }

  describe 'GET /index' do
    let!(:project) { create(:project, user: user) }

    it 'アクセスできること' do
      get users_projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    let!(:project) { create(:project, user: user) }

    it 'アクセスできること' do
      get edit_users_project_path(project)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /users/projects/:id' do
    let!(:project) { create(:project, name: 'test name', user: user) }
    let(:params) { { project: { name: 'updated name' } } }

    it '更新できること' do
      patch users_project_path(project), params: params
      expect(project.reload.name).to eq 'updated name'
      expect(response).to redirect_to edit_users_project_path(project)
    end
  end

  describe 'DELETE /users/projects/:id' do
    let!(:project) { create(:project, user: user) }

    it '更新できること' do
      expect{
        delete users_project_path(project)
      }.to change(Project, :count).by(-1)
      expect(response).to redirect_to users_projects_path
    end
  end
end
