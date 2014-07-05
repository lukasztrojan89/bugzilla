class ProjectDecorator < Draper::Decorator
  delegate_all
  def email
    user.email
  end

end
