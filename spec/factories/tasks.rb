FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Tarea #{n}" }
    sequence(:description) { |n| "Descripción de la tarea #{n}" }
    sequence(:due_date) { Date.today + n.day }
    #association with category
    category
    #association with owner through user factory
    association :owner, factory: :user


    factory :task_with_participants do
      #define the number of participants
      transient do
        participants_count { 5 }
      
      end
      
      after(:build) do |task, evaluator|
        # build the participants
        task.participants = build_list(
          :participant,
          evaluator.participants_count,
          task: task,
          role: 1
        )
      
        task.category.save
        task.owner.save      
      end
    end
  end
end