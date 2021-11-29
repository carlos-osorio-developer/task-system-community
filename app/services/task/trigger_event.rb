class Task::TriggerEvent
  def call(task, event)
    #dynamic way to tell task.start!, it is sending "#{event}!" method to task
    task.send "#{event}!"    
    [true, 'success'] 
  rescue => e
    Rails.logger.error e
    [false, 'failed']
  end
end