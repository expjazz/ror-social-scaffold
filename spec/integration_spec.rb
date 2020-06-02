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
      user3 = FactoryBot.create(:user)
      Friendship.create(active: user3, passive: friend, status: false)
      visit root_path
      fill_in 'Email', with: friend.email
      fill_in 'Password', with: 'foobar'
      click_on 'Log in'
      click_on 'All users'
      find('.friends', match: :first).click
      expect(page).to have_content('Friends')
    end
  end
end
