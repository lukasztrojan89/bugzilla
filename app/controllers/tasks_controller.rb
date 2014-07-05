class TasksController < ApplicationController
  before_action :set_stories, only: [:new, :create, :destroy]



  def new
    @task = @story.tasks.new
  end

  def create
    @task = @story.tasks.new(task_params)
    if @task.save
      @story.project.create_activity key: 'project.new_task', owner: current_user
      redirect_to edit_project_story_path(@story.project_id,@story), notice: "New task was added to #{@story.name}"
    else
      render :new, status: 422
    end
  end

  def destroy
    @story.tasks.find(params[:id]).destroy
    #@task.destroy
    @story.project.create_activity key: 'project.remove_task', owner: current_user
    redirect_to :back
  end

  private
  def set_stories
    @story = Story.find(params[:story_id])
  end


  def task_params
    params.require(:task).permit(:text)
  end
end