class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM

  field :name, type: String
  field :description, type: String
  field :due_date, type: Date
  field :code, type: String
  field :status, type: String
  field :transitions, type: Array, default: []

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

    after_all_transitions :audit_status_change

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def audit_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    set transitions: transitions.push(
        {
          from_state: aasm.from_state,
          to_state: aasm.to_state,
          current_event: aasm.current_event,
          timestamp: Time.zone.now
        }
      )
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
    #same as Tasks::SendEmail.new.call(self)
  end
end
