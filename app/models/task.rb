class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'  

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false}
  validates :due_date, presence: true
  # disallow past due dates
  validate :future_due_date

  def future_due_date
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errrors.invalid_due_date')
  end
end
