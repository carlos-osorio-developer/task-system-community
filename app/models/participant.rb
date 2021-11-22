class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user, uniqueness: { scope: :task }
end
