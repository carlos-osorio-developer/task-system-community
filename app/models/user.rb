class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :own_tasks, class_name: 'Task', foreign_key: 'owner_id', dependent: :destroy

  has_many :commits, class_name: 'Participant'
  has_many :commitments, through: :commits
end
