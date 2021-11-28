class Task::SendEmail
  def call(task)
    part_users = task.participants.map(&:user)
    ([task.owner] + part_users).each do |user|      
      ParticipantMailer.with(user: user, task: task).new_task_email.deliver!
    end
    [true, 'Email sent']
  rescue => e
    Rails.logger.error e
    [false, 'Email not sent']
  end
end