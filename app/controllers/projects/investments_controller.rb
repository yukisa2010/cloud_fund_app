class Projects::InvestmentsController < ApplicationController
  before_action :set_project, only: %i[new create]

  def new
    redirect_to project_path(@project), notice: '自身のプロジェクトには投資できません。' if @project.investable?(current_user)
    @investment = @project.investments.new(user: current_user)
  end

  def create
    @investment = @project.investments.new(user: current_user)
    @investment.assign_attributes(investment_params)

    if @investment.save
      redirect_to project_path(@project), notice: '投資されました'
    else
      render :new
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
