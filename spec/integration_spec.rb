require 'rails_helper'
require 'webdrivers'
RSpec.describe 'Testing the login', type: :system do
  user = FactoryBot.build(:user)

  feature 'authentication system for Sign up' do
    scenario 'Sign Up with valid params' do
      visit root_path
      click_on 'Sign up'
      fill_in 'Name', with: user.name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_on 'Sign up'
      expect(page).to have_content('Recent posts')
    end
    scenario 'Sign up with invalid email' do
      visit root_path
      click_on 'Sign up'
      click_on 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end
  end
  feature 'authentication system for logging in' do
    scenario 'Sign Up with valid params' do
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      expect(page).to have_content('Recent posts')
    end
    scenario 'Sign up with invalid email' do
      visit root_path
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  feature 'Friendship' do
    user2 = FactoryBot.create(:user)
    friend = User.first
    scenario 'make the request' do
      visit root_path
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      click_on 'Log in'
      click_on 'All users'
      expect(page).to have_content(friend.name)
      find('.add', match: :first).click
      expect(page).to have_content('Waiting For Confirmation')
    end

    scenario 'accept request' do
      visit root_path
      fill_in 'Email', with: friend.email
      fill_in 'Password', with: 'foobar'
      click_on 'Log in'
      click_on 'All users'
      find('.friends', match: :first).click
      expect(page).to have_content('Friends')
    end
  end
  # feature 'Event creation' do
  #   scenario 'with valid params' do
  #     visit root_path
  #     fill_in 'Email', with: user.email
  #     click_on 'Log in'
  #     expect(page).to have_content('List of all Events')
  #     visit 'events/new'
  #     fill_in 'Name', with: event.name
  #     fill_in 'Description', with: event.description
  #     fill_in 'Location', with: event.location
  #     fill_in 'Date', with: event.date
  #     fill_in 'invitedlist', with: 'expeditojazz@gmail.com'
  #     click_on 'Create Event'
  #     visit root_path
  #     expect(page).to have_content(event.name)
  #     expect(Event.find_by(name: event.name)).to be_an(Event)
  #   end
  # end
end
