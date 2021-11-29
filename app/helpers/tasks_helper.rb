module TasksHelper

  def available_events_for(task)
    task.aasm.events.map(&:name)
  end
end
