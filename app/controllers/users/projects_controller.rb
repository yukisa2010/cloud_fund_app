class Users::ProjectsController < Users::BaseController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to users_projects_path, notice: 'プロジェクトが作成されました！'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.assign_attributes(project_params)

    if @project.save
      redirect_to edit_users_project_path, notice: 'プロジェクトが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy!

    redirect_to users_projects_path, status: :see_other, notice: 'プロジェクトが削除されました。'
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
