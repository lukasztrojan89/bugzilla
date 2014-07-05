class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  hide_action :current_user

  before_action :authenticate_user!
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    resource.present?  ? projects_path : root_path
  end
end
