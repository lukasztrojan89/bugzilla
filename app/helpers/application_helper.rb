module ApplicationHelper
  def signed_in?
    !current_user.nil?
  end

  def button_status(status)
    case status
      when STORY::STATUS_UNSTARTED
        "STARTUJ"
      when STORY::STATUS_STARTED
        "FINISZUJ"
      when STORY::STATUS_FINISHED
        "DELIVERUJ"
      when STORY::STATUS_DELIVERED
        "AKCEPT I REJECTED"
    end
  end


  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
