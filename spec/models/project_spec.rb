require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '#investments_total' do
    let(:project) { create(:project, target_amount: 500_000) }

    before { create_list(:investment, 3, amount: 20_000, project: project) }

    it '紐づくinvestmentのamountの合計を返すこと' do
      expect(project.investments_total).to eq 60000
    end
  end

  describe '#owner?' do
    let(:user) { create(:user, status: :normal) }
    let!(:other_user) { create(:user, status: :normal) }
    let!(:project) { create(:project, target_amount: 500_000, user: user) }

    context 'projectのオーナーを指定した場合' do
      it { expect(project.owner?(user)).to be true }
    end

    context 'projectのオーナー以外を指定した場合' do
      it { expect(project.owner?(other_user)).to be false }
    end
  end
end
