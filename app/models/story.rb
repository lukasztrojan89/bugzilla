class Story < ActiveRecord::Base
  STATUSES = [STATUS_REJECTED ='Rejected',
              STATUS_STARTED = 'Started',
              STATUS_UNSTARTED = 'Unstarted',
              STATUS_FINISHED = 'Finished',
              STATUS_DELIVERED = 'Delivered',
              STATUS_ACCEPTED = 'Accepted'
  ]

  belongs_to :project
  has_many :comments
  has_many :tasks
  validates :name, :description, presence: true

end