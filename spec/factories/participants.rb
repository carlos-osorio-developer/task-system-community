FactoryBot.define do
  factory :participant do
    #Busca la user_factoru para construir un usuario y asociarlo al registro de participante.
    association :user 

    #Así cuando se cree un participante se definirá un rol asociado.
    #Ya sea responsible o follower
    trait :responsible do
      role { Participant::ROLES[:responsible] }    
    end
      
    trait :follower do
      role { Participant::ROLES[:follower] }  
    end
    
    #ejecuta el save cuando el registro participant termina su construcción
    #así se asegura que el regitro de usuario sea persistido
    after(:build) do |participant, _|
      participant.user.save    
    end
  end
end