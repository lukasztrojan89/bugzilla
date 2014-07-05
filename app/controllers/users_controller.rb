class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :update_password]

  def update_password
    if params[:user][:custom_password] == params[:user][:password_conf]
      @user.update!(password: params[:user][:custom_password])
      sign_in(@user, :bypass => true)
      redirect_to projects_path, :notice => 'Your password has been sucessfully changed'
    else
      render :edit, status: 422
    end
  end

  def show
  end

  def edit
  end

  def new

  end

  private
  def set_users
    @user = current_user
  end
end

#def update_password
#  if params[:user][:custom_password] == params[:user][:password_conf]
#    @user.update!(password: params[:user][:custom_password])
#    sign_in(@user, :bypass => true)
#    redirect_to projects_path, :notice => 'Your password has been sucessfully changed'
#  else
#    redirect_to edit_user_path, :notice => 'Hasła nie są takie same.'
#  end
#end
