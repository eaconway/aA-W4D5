require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe 'GET #index' do
    it 'renders the new links page' do
      get :index
      expect(response).to render_template(:index)
    end
    
    # it 'doesnt render private goals' do
    #   user = User.create(email:'ej@ej.com',password:'starwars')
    #   Goal.create(title:'My private goal', user_id: user.id, state: 'private')
    #   get :index
    #   expect(page).not_to have_content('My private goal')
    # end
  end
  
  describe 'GET #new' do
    it 'renders the new links page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe 'GET #edit' do
    it 'renders the edit page' do
      user = User.create(email:'ej@ej.com',password:'starwars')
      goal = Goal.create(title:'My private goal', user_id: user.id, state: 'private')
      get :edit, params: {id: goal.id}
      expect(response).to render_template(:edit)
    end
  end
  
  describe 'PATCH #update' do
    it 'updates goal' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      goal = Goal.create(title:'My private goal', user_id: user.id, state: 'private')
      patch :update, params: {id: goal.id, goal: {goal:'My private goal2', state: 'private'}}
      expect(Goal.find_by(goal:'My private goal2')).not_to be_nil
    end
  
    it 'redirects to users page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      goal = Goal.create(title:'My public goal', user_id: user.id, state: 'public')
      patch :update, params: {id: goal.id, goal: {goal:'My private goal2', state: 'private'}}
      
      expect(response).to redirect_to(user_url(user.id))
    end
  end
  # 
  describe 'DELETE #destroy' do
    it 'deletes a goal' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      goal = Goal.create(title:'My private goal', user_id: user.id, state: 'private')
      delete :destroy, params: {id: goal.id}
      expect(Goal.find_by(email: 'My private goal')).to be_nil
    end
  
    it 'sends back to the Sign Up page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      goal = Goal.create(title:'My private goal', user_id: user.id, state: 'private')
      delete :destroy, params: {id: goal.id}
      expect(response).to redirect_to(goals_url)
    end
  end
  
end