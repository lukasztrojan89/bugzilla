class TasksController < ApplicationController
  before_action :set_stories, only: [:new, :index, :edit, :create]
  before_action :set_task, only: [:edit]


  def index
    @tasks = Task.all
  end

  def new
    @task = @story.tasks.new
  end

  def create
    @task = @story.tasks.new(task_params)
    if @task.save
      redirect_to edit_project_story_path(@story.project_id,@story), notice: "New task was added to #{@story.name}"
    else
      render :new
    end
  end

  private
  def set_stories
    @story = Story.find(params[:story_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:text)
  end
end