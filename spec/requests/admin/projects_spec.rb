require 'rails_helper'

RSpec.describe 'Admin::Projects', type: :request do
  let(:admin_user) { create(:user, status: :admin) }
  let!(:project) { create(:project) }

  before { sign_in admin_user }

  describe 'GET /admin/projects' do
    it 'アクセスできること' do
      get admin_projects_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /admin/projects/new' do
    it 'アクセスできること' do
      get new_admin_project_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /admin/projects' do
    let!(:user) { create(:user) }

    context '正常系' do
      let(:params) {
        { project: { name: 'name', description: 'description', user_id: user.id } }
      }

      it 'projectが作成されること' do
        expect{
          post admin_projects_path, params: params
        }.to change(Project, :count).by(1)
        expect(response).to redirect_to admin_projects_path
      end
    end

    context '異常系' do
      context 'invalidな値が送られた場合' do
        let(:params) {
          { project: { name: '', description: 'description', user_id: user.id } }
        }

        it 'projectが作成されないこと' do
          expect{
            post admin_projects_path, params: params
          }.to change(Project, :count).by(0)
        end
      end
    end
  end

  describe 'GET /admin/project/:id/edit' do
    it 'アクセスできること' do
      get edit_admin_project_path(project)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /admin/projects/:id' do
    let!(:user) { create(:user) }
    let(:project) { create(:project, name: 'test project', user: user) }

    context '正常系' do
      let(:params) {
        { project: { name: 'updated_name', description: 'description', user_id: user.id } }
      }

      it 'projectが作成されること' do
        patch admin_project_path(project), params: params
        expect(project.reload.name).to eq 'updated_name'
        expect(response).to redirect_to edit_admin_project_path(project)
      end
    end

    context '異常系' do
      context 'invalidな値が送られた場合' do
        let(:params) {
          { project: { name: '', description: 'description', user_id: user.id } }
        }

        it 'projectが更新されないこと' do
          patch admin_project_path(project), params: params
          expect(project.reload.name).to eq 'test project'
        end
      end
    end
  end
end
