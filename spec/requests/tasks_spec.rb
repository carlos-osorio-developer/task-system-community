require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  # se crea un usuario, y con el helper de integración sign_in, se inicia sesión
  let(:user) { create :user }
  before(:each) { sign_in user }

  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      get tasks_path
      expect(response).to have_http_status(200)
    end    
  end

  describe "GET /tasks/new" do
    it "works! (now write some real specs)" do
      get new_task_path
      expect(response).to render_template(:new)
    end    
  end

  describe "POST /tasks" do
    let(:category) { create :category }
    let(:participant) { create :user }
    let(:params) do
      {
        "task"=>{
          "name"=>"Task name test", 
          "due_date"=> Date.tomorrow, 
          "category_id"=> category.id.to_s, 
          "description"=>"Task description test", 
          "participants_attributes"=>{
            "0"=>{
              "user_id"=> participant.id.to_s, 
              "role"=> "1", 
              "_destroy"=> "false"
            }
          }          
        }
      }
    end

    it 'creates a task and redirect to show page' do
      post '/tasks', params: params

      #assigns sirve para evaluar un redirect_to @task
      expect(response).to redirect_to(assigns(:task))
      
      follow_redirect! #sirve para evaluar el contenido de la página a la que se redirigió
      expect(response).to render_template(:show)
      expect(response.body).to include('Task was successfully created.')

    end
  end
end
