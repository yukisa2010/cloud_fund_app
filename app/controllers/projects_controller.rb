class ProjectsController < ApplicationController
  before_action :set_projects, only: :index
  before_action :set_project, only: %i[show]

  def index
  end

  def show
  end

  private

  def set_projects
    @projects = Project.all
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
