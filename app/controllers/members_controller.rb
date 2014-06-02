class MembersController < ApplicationController
  before_action :set_project, only: [:edit, :new, :create, :destroy, :confirm, :update]
  before_action :set_member, only: [:edit, :update]

  def index
    @members = Member.all
  end

  def new
    @member = @project.members.new
  end

  def edit
  end

  def create
    @member = @project.members.new(member_params)
    #Member.create!(name: name, email: email, project_id: project_id, projectmanager: projectmanager, authentication_token: token)
    @member.authentication_token = @member.token
    if @member.save
      redirect_to edit_project_path(@project), notice: "New member was added to #{@project.title}"
    else
      render :new
    end
  end

  def update
    if @member.update(member_params)
      redirect_to edit_project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.members.find(params[:id]).destroy
    redirect_to edit_project_path(@project), notice: " member was deleted"
  end

  def confirm
     @project.members.find(params[:id]).update!(confirm: true)
    redirect_to static_pages_home_path
  end

  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email)
  end


end