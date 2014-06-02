class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy, :show]
  before_action :set_stories, only: [:show]

  def index
    #@projects = current_user.projects.page(params[:page]).per(8)
    @projects = Project.joins(:members).where('members.email = ? And confirm = true',current_user.email).page(params[:page]).per(8)

  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def confirm_mail

  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def set_stories

  end

  def project_params
    params.require(:project).permit(:title)
  end
end