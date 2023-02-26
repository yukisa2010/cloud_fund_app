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

  describe 'GET /new' do
    it 'アクセスできること' do
      get new_users_project_path
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

  describe 'POST /users/projects' do
    context '正常系' do
      let(:params) { { project: { name: 'name', description: 'description' } } }

      it '新規作成できること' do
        expect { post users_projects_path, params: params }.to change(Project, :count).by(1)
        expect(response).to redirect_to users_projects_path
      end
    end

    context '異常系' do
      context 'invalidな値を渡した場合' do
        let(:params) { { project: { name: '', description: 'description' } } }

        it '新規作成されないこと' do
          expect { post users_projects_path, params: params }.to change(Project, :count).by(0)
        end
      end
    end
  end

  describe 'PATCH /users/projects/:id' do
    let!(:project) { create(:project, name: 'test name', description: 'description', user: user) }

    context '正常系' do
      let(:params) { { project: { name: 'updated name', description: 'description' } } }

      it '更新できること' do
        patch users_project_path(project), params: params
        expect(project.reload.name).to eq 'updated name'
        expect(response).to redirect_to edit_users_project_path(project)
      end
    end

    context '異常系' do
      context 'invalidな値が渡された場合' do
        let(:params) { { project: { name: '', description: 'description' } } }

        it '更新できないこと' do
          patch users_project_path(project), params: params
          expect(project.reload.name).to eq 'test name'
        end
      end
    end
  end

  describe 'DELETE /users/projects/:id' do
    let!(:project) { create(:project, user: user) }

    it '削除できること' do
      expect{
        delete users_project_path(project)
      }.to change(Project, :count).by(-1)
      expect(response).to redirect_to users_projects_path
    end
  end
end
