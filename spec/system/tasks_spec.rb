require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }  
  
  describe 'GET/tasks' do
    it 'has the right title' do 
      visit '/tasks'
      expect(page).to have_content 'Lista de Tareas'
    end
  end

  describe 'POST /tasks' do
    #needs a bang because it has to be created before the let is called on line 27
    #otherwise the select will be nil at that point
    let!(:category) { create :category }  
    let!(:participant) { create :user }  
    it 'creates new task with dinamyc participant button', js: true do 
      visit '/tasks/new'
      fill_in 'task[name]', with: 'Task 1'
      fill_in 'task[description]', with: 'Description 1'
      fill_in 'task[due_date]', with: Date.tomorrow
      select category.name, from: 'task[category_id]'

      click_link 'Agregar un participante'   
      xpath = '//*[@id="addParticipants"]/div/div[1]'
      within(:xpath, xpath) do
        select participant.email, from: 'Usuario'
        select 'responsible', from: 'Rol'
      end

      click_button 'Crear Task'

      expect(page).to have_content 'Task was successfully created.'
    end
  end
end
