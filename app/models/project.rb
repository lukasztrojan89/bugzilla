class Project < ActiveRecord::Base

  include PublicActivity::Model

  after_create :add_member

  belongs_to :user
  has_many :members
  has_many :stories

  validates :title, presence: true
  validates :title, length: {in: 3..12 }

  scope :own, ->(user) { where(user_id: user.id) }

  private

  def add_member
    members.create!(name: user.email, email: user.email, projectmanager: true, confirm: true)
  end

end