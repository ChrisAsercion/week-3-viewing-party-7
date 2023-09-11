require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  describe 'emails instead of show' do
    #Task 4
    scenario 'the landing page only shows the emails of each of the users, not the link to their show page' do
      user = User.create(name: "Johnny Joestar", email: "horserider@gmail.com", password: "test123")

      user2 = User.create(name: "Gyro Zeppeli", email: "falloffyour@horse.com", password: "spin123")

      visit root_path 

      expect(page).to have_content(user.email)
      expect(page).to have_content(user2.email)
      
    end
  end

  #task 5 story 3
  describe 'dashboard error alert' do
    scenario 'I click dashboard, but I am not logged in' do
      user = User.create(name: "Johnny Joestar", email: "horserider@gmail.com", password: "test123")
      visit root_path

      visit user_path(user)
      
    end
  end
end
