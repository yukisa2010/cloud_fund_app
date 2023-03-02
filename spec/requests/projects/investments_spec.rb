require 'rails_helper'

RSpec.describe 'Projects::Investments', type: :request do
  describe 'GET /new' do
    context '正常系' do
      let(:user) { create(:user, status: :normal) }
      let(:other_user) { create(:user, status: :normal) }
      let(:project) { create(:project, user: other_user) }

      before { sign_in user }

      it 'アクセスできること' do
        get new_investment_path(project)
        expect(response).to have_http_status(:success)
      end
    end

    context '異常系' do
      context 'ユーザーがサインインしていない場合' do
        let(:project) { create(:project) }

        it 'ログイン画面へリダイレクトすること' do
          get new_investment_path(project)
          expect(response).to redirect_to new_user_session_path
        end
      end

      context '自分で作成したプロジェクトが対象の場合' do
        let(:user) { create(:user) }
        let(:project) { create(:project, user: user) }

        before { sign_in user }

        it 'project詳細画面へリダイレクトすること' do
          get new_investment_path(project)
          expect(response).to redirect_to project_path(project)
        end
      end
    end
  end

  describe "POST /" do
    context '正常系' do
      let(:user) { create(:user, status: :normal) }
      let(:other_user) { create(:user, status: :normal) }
      let(:project) { create(:project, user: other_user) }
      let(:params) { { investment: { amount: 100 } } }

      before { sign_in user }

      it '対象プロジェクトのinvestmentが作成され、プロジェクト詳細へリダイレクトすること' do
        expect {
          post investment_path(project), params: params
        }.to change(Investment, :count).by(1)
        expect(Investment.last.amount).to eq 100
        expect(Investment.last.project_id).to eq project.id
        expect(response).to redirect_to project_path(project)
      end
    end

    context '異常系' do
      context 'ユーザーがサインインしていない場合' do
        let(:project) { create(:project) }
        let(:params) { { investment: { amount: 100 } } }

        it 'investmentは作成されず、ログイン画面へリダイレクトすること' do
          expect {
            post investment_path(project), params: params
          }.to change(Investment, :count).by(0)
          expect(response).to redirect_to new_user_session_path
        end
      end

      context '自分で作成したプロジェクトを対象に投資した場合' do
        let(:user) { create(:user) }
        let(:project) { create(:project, user: user) }
        let(:params) { { investment: { amount: 100 } } }

        before { sign_in user }

        it 'investmentは作成されず、プロジェクト詳細画面へリダイレクトすること' do
          expect {
            post investment_path(project), params: params
          }.to change(Investment, :count).by(0)
          expect(response).to redirect_to project_path(project)
        end
      end
    end
  end
end
