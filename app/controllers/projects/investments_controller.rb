class Projects::InvestmentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_project, only: %i[new create]
  before_action :check_project_owner

  def new
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

  def authenticate_user
    redirect_to new_user_session_path, notice: '投資するにはサインインが必要です。' unless user_signed_in?
  end

  def check_project_owner
    redirect_to project_path(@project), notice: '自身のプロジェクトには投資できません。' if @project.owner?(current_user)
  end

  def investment_params
    params.require(:investment).permit(:amount)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
