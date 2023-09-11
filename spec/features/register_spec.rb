require 'rails_helper'

RSpec.describe 'Register Page' do
  it 'registers a new user' do

    visit register_path

    fill_in :user_name, with: "Johnny Test"
    fill_in :user_email, with: "funbucket13@solar.com"
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"

    click_on "Create New User"
    
    expect(page).to have_content("Johnny Test's Dashboard")

  end

  #US 2
  it 'displays a message if the passwords do not match' do
    visit register_path

    fill_in :user_name, with: "Johnny Test"
    fill_in :user_email, with: "funbucket13@solar.com"
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test321"

    click_on "Create New User"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'the client will see a Log In section on the Landing page' do
    user = User.create(name: "Johnny Joestar", email: "horserider@gmail.com", password: "test123")
    
    visit register_path

    expect(page).to have_link("Log In")
    click_on("Log In")

    expect(current_path).to eq(login_form_path)
    
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    #fill_in :user_password_confirmation, with: "test123"

    click_on("Log In")

    expect(current_path).to eq(user_path(user))
    
    expect(page).to have_content("Welcome, Johnny Joestar!")
  end


  describe 'sessions challenge' do
    #Task 2
    scenario 'log out' do
      user = User.create(name: "Johnny Joestar", email: "horserider@gmail.com", password: "test123")
      
      visit login_form_path
      
      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password

      click_on("Log In")
      
      click_on("Home")
      
      expect(page).to have_link("Log Out")

      click_on("Log Out")
      
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Logged out successfully")
      expect(page).to have_button("Create New User")
      
    end
  end
end