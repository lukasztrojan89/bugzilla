class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  #before_action :set_stories, only: [:show]

  def index
    #@projects = current_user.projects.page(params[:page]).per(8)
    @projects = Project.joins(:members).where('members.email = ? And confirm = true', current_user.email).page(params[:page]).per(8)
    @activities = PublicActivity::Activity.order(created_at: :desc)
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'Post was successfully created.'
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def show
    @project = Project.find(params[:id])
    @project_decorator = ProjectDecorator.decorate(@project)
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @project.destroy
    #@project.create_activity key: 'project.destroy', owner: current_user
    redirect_to projects_path
  end

  #def confirm_mail
  #
  #end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end