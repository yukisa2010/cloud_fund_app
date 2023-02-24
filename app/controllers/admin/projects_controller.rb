class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = Project.order(:id)
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_projects_path, notice: 'プロジェクトが新規作成されました！'
    else
      render :new
    end
  end

  def update
    @project.assign_attributes(project_params)

    if @project.save
      redirect_to edit_admin_project_path, notice: 'プロジェクトが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy!

    redirect_to admin_projects_path, status: :see_other, notice: 'プロジェクトが削除されました。'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id)
  end
end
