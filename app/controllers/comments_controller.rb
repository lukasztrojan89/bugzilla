class CommentsController < ApplicationController
  before_action :set_stories, only: [:new,  :create, :destroy]


  def new
    @comment = @story.comments.new
  end

  def create
    @comment = @story.comments.new(comment_params)
    if @comment.save
      @story.project.create_activity key: 'project.new_comment', owner: current_user
      redirect_to edit_project_story_path(@story.project_id, @story), notice: "New comment was added to #{@story.name}"
    else
      render :new, status: 422
    end
  end

  def destroy
    @story.comments.find(params[:id]).destroy
    @story.project.create_activity key: 'project.remove_comment', owner: current_user
    redirect_to :back
  end

  private
  def set_stories
    @story = Story.find(params[:story_id])
  end

  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end