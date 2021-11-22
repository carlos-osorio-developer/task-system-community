class AddUniqueIndexToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_index :participants, [:user_id, :task_id], unique: true
  end
end
