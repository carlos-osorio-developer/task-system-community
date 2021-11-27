class Participant
  include Mongoid::Document
  include Mongoid::Timestamps

  ROLES = {
    responsible: 1, 
    follower: 2
  }

  field :role, type: Integer
  
  belongs_to :user
  belongs_to :task

  validates :user, uniqueness: { scope: :task }

  def self.roles #expose roles for use in views
    ROLES
  end

end
