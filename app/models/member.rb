class Member < ActiveRecord::Base
  belongs_to :project
  after_create :invite_by_email
  validates :name, :email ,presence: true
  validates :email , format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  def token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  private
  def invite_by_email
    Mailer.invitation_mail(project,self).deliver if self.authentication_token
  end

end