class Project < ActiveRecord::Base

  after_create :add_member

  belongs_to :user
  has_many :members
  has_many :stories

  validates :title, presence: true

  scope :own, ->(user) { where(user_id: user.id) }

  def add_member
    members.create!(name: user.email, email: user.email, projectmanager: true, confirm: true)
  end

end