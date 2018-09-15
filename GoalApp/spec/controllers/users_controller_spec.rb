require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new links page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      it 'logs the user in' do
        post :create, params: {user: {email: 'ej@ej.com', password: 'starwars'}}
        
        user = User.find_by(email: 'ej@ej.com')
        expect(session[:session_token]).to eq(user.session_token)
      end
      
      it 'redirects to user show page' do
        post :create, params: {user: {email: 'ej@ej.com', password: 'starwars'}}
        
        user = User.find_by(email: 'ej@ej.com')
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context 'without valid params' do
      it 'validates the presence of password and renders new temp w/ errors' do
        post :create, params: {user: {email: 'ej@ej.com'}}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
  
  describe 'GET #show' do
    it 'renders the user page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end
  
  describe 'GET #index' do
    it 'renders the index page' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      get :edit, params: {id: user.id}
      expect(response).to render_template(:edit)
    end
  end
  # 
  describe 'PATCH #update' do
    it 'updates user' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      patch :update, params: {id: user.id, user: {email: 'ej@ej2.com', password: 'starwars'}}
      expect(User.find_by(email: 'ej@ej2.com')).not_to be_nil
    end
  
    it 'redirects to user page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      patch :update, params: {id: user.id, user: {email: 'ej@ej2.com', password: 'starwars'}}
      
      expect(response).to redirect_to(user_url(user.id))
    end
  end
  # 
  describe 'DELETE #destroy' do
    it 'deletes a user' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
  
      delete :destroy, params: {id: user.id}
      expect(User.find_by(email: 'ej@ej.com')).to be_nil
    end
  
    it 'sends back to the Sign Up page' do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
  
      delete :destroy, params: {id: user.id}
      expect(response).to redirect_to(users_url)
    end
  end


end

