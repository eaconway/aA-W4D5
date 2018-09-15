require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_url
  end
  
  scenario 'has a new user page' do
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do
    
    scenario 'shows username on the homepage after signup' do 
      fill_in 'Email', with: 'ej@ej.com'
      fill_in 'Password', with: 'starwars'
      click_button 'Sign Up' 
      expect(page).to have_content('ej@ej.com')
    end
  end
end

feature 'logging in' do
  background :each do
    visit new_session_url
  end
  
  scenario 'has a sign in page' do
    expect(page).to have_content('Sign In')
  end
  
  scenario 'shows username on the homepage after login' do
    User.create(email:'this@that.com', password: 'starwars')
    fill_in 'Email', with: 'this@that.com'
    fill_in 'Password', with: 'starwars'
    click_button 'Sign In' 
    expect(page).to have_content('this@that.com')
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    user = User.create(email: 'ej@ej.com', password: 'starwars')
    visit user_url(user)
    
    click_button 'Logout' 
    expect(page).not_to have_content('ej@ej.com')
  end
end