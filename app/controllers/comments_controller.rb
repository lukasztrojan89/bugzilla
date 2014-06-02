class CommentsController < ApplicationController
  before_action :set_stories, only: [:new, :index, :edit, :create]
  before_action :set_comments, only: [:edit]

  def index
    @comments = Comment.all
  end

  def new
    @comment = @story.comments.new
  end

  def create
    @comment = @story.comments.new(comment_params)
    if @comment.save
      redirect_to edit_project_story_path(@story.project_id, @story), notice: "New comment was added to #{@story.name}"
    else
      render :new
    end
  end

  private
  def set_stories
    @story = Story.find(params[:story_id])
  end

  def set_comments
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end