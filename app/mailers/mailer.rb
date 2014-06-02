class Mailer < ActionMailer::Base
  default :from => "bugzilla@example.com"

  def invitation_mail(project,member)
    @project = project
    @member = member
    mail(:to => member.email, :subject => "Welcome")
  end
end