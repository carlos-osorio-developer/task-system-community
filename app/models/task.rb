class Task < ApplicationRecord
  belongs_to :category


  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false}
  validates :due_date, presence: true
  
end
