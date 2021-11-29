class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM

  field :name, type: String
  field :description, type: String
  field :due_date, type: Date
  field :code, type: String
  field :status, type: String

  before_create :create_code
  after_create :send_email

  belongs_to :category
  belongs_to :owner, class_name: 'User'  

  has_many :participants, dependent: :destroy
  # has_many :commited_users, through: :participants, source: :user

  has_many :notes, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false}
  validates :due_date, presence: true
  # disallow past due dates
  validate :future_due_date

  accepts_nested_attributes_for :participants, allow_destroy: true

  aasm column: :status do
    state :pending, initial: true
    state :in_process, :finished

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def commited_users
    participants.includes(:user).map(&:user)
  end
  
  def future_due_date
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errrors.invalid_due_date')
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(4)}"
  end

  
  def send_email
    return unless Rails.env.development?
    Tasks::SendEmailJob.perform_async id.to_s
    #same as Task::SendEmail.new.call(self)
  end
end
