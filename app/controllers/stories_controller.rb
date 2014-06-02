class StoriesController < ApplicationController
  before_action :set_project, only: [:new, :create, :destroy, :edit, :index, :update]
  before_action :set_stories, only: [:edit, :update, :destroy]
  before_action :set_project_for_show, only: [:show, :icebox, :backlog, :current, :done]

  def index
    @stories = @project.stories
    #redirect_to project_path(@project)
  end

  def icebox
  end

  def show
    @stories = @project.stories
  end
  def backlog
  end


  def current
  end

  def done
  end

  def new
    @story = @project.stories.new
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to story_path(@project)
    else
      render :edit
    end
  end

  def create
    @story = @project.stories.new(story_params)
    if @story.save
      redirect_to story_path(@project), notice: "New story was added to #{@project.title}"
    else
      render :new
    end
  end

  def destroy
    @project.stories.find(params[:id]).destroy
    redirect_to story_path(), notice: " stories was deleted"
  end

  private
  def set_project_for_show
    @project = Project.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_stories
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:name, :type_of_story, :owner, :status, :description, :form_of_box)
  end

end