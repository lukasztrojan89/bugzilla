class Member < ActiveRecord::Base
  belongs_to :project
  after_create :invite_by_email

  def token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  private
  def invite_by_email
    Mailer.invitation_mail(project,self).deliver if self.authentication_token
  end

end