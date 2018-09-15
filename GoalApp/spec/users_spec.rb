require 'rails_helper'

RSpec.describe User, type: :model do
  let (:incomplete_user) {User.new(email: 'ej@ej.com', password: 'starwars')}
  
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  
  it {should validate_length_of(:password).is_at_least(6)}
  
  describe "session_token" do
    it "assins session token if it isn't given one" do
      user = User.create(email: 'ej@ej.com', password: 'starwars')
      expect(user.session_token).not_to be_nil
    end
  end
  
  describe 'password encryption' do
    it 'does not save passwords to db' do
      ej = User.create(email: 'ej@ej.com', password: 'starwars')
      user = User.find_by( email: 'ej@ej.com')
      expect(user.password).not_to be('starwars')
    end
    
    it 'encrypts password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('starwars')
      User.new(email: 'ej@ej.com', password: 'starwars')
    end
  end
  
end