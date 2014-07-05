class StoriesController < ApplicationController
  before_action :set_project, only: [:new, :create, :destroy, :edit, :update]
  before_action :set_stories, only: [:edit, :update, :destroy, :sort_column]
  before_action :set_project_for_show, only: [:show, :icebox, :backlog, :current, :done]
  helper_method :sort_column, :sort_direction


  def icebox
  end

  def show
    @stories = @project.stories
  end

  def backlog
  end


  def current
    @stories =@project.stories.order(sort_column + " " + sort_direction)
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
      redirect_to :back
      #redirect_to backlog_story_path(@project) if(@story.status == 'Started')
      #redirect_to icebox_story_path(@project) if(@story.status == 'Unstarted')
      #redirect_to  current_story_path(@project) if(@story.status == 'Finished' or @story.status == 'Delivered' or @story.status == 'Accepted' or @story.status == 'Rejected')
    else
      render :edit, status: 422
    end
  end

  def create
    @story = @project.stories.new(story_params)
    if @story.save
      @project.create_activity key: 'project.new_story', owner: current_user
      redirect_to story_path(@project), notice: "New story was added to #{@project.title}"
    else
      render :new, status: 422
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


  def sort_column
    Story.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end