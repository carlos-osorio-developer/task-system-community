require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create :user }
  before(:each) { sign_in user }

  before do
    driven_by(:rack_test)
  end
  
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
    it 'has the right title' do 
      visit '/tasks/new'
      fill_in 'task[name]', with: 'Task 1'
      fill_in 'task[description]', with: 'Description 1'
      fill_in 'task[due_date]', with: Date.tomorrow
      select category.name, from: 'task[category_id]'
    end
  end
end
