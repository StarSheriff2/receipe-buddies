require 'rails_helper'

RSpec.describe 'User Actions', type: :system do
  describe 'root page and userpage' do
    it 'allows user to create new account' do
      visit root_path
      sleep(2)
      click_link 'Sign up'
      sleep(2)
      fill_in 'Username', with: 'Maria_Foodie'
      fill_in 'Fullname', with: 'Maria Foodie'
      click_button 'Sign up'
      expect(page).to have_content('MARIA FOODIE')
      sleep(2)
    end

    it 'allows user to sign in and sign out' do
      visit root_path
      sleep(2)
      fill_in 'Username', with: 'Maria_Foodie'
      click_button 'Sign in'
      expect(page).to have_content('MARIA FOODIE')
      page.click_link('', href: '/logout')
      expect(page).to have_content('Sign in')
      sleep(2)
    end

    it 'allows user to create new account with photo and cover photo' do
      visit root_path
      sleep(2)
      click_link 'Sign up'
      sleep(2)
      fill_in 'Username', with: 'Bruce_Wayne'
      fill_in 'Fullname', with: 'Bruce Wayne'
      attach_file 'user_avatar', "#{Rails.root}/spec/assets/test_profile_image.jpg"
      attach_file 'user_cover_image', "#{Rails.root}/spec/assets/test_cover_picture.jpg"
      sleep(2)
      click_button 'Sign up'
      expect(page).to have_content('BRUCE WAYNE')
      sleep(2)
    end

    it 'allows user to follow and unfollow another user' do
      visit root_path
      sleep(2)
      fill_in 'Username', with: 'Maria_Foodie'
      click_button 'Sign in'
      sleep(2)
      click_link 'Bruce Wayne'
      sleep(2)
      page.find(:css, '.profile-info-picture-div a[rel="nofollow"]').click
      expect(page).to have_content('You are now following this user.')
      sleep(2)
      page.find(:css, '.profile-info-picture-div a[rel="nofollow"]').click
      expect(page).to have_content('You have successfully unfollowed this user.')
    end

    it 'allows user to create an opinion' do
      visit root_path
      sleep(2)
      fill_in 'Username', with: 'Maria_Foodie'
      click_button 'Sign in'
      within('.create-new-opinion form') do
        fill_in 'opinion_text', with: 'This opinion is a test.'
        sleep(2)
        click_on 'SHARE'
      end
      expect(page).to have_content('Opinion was successfully created.')
    end

    it 'allows user to vote and unvote an opinion' do
      visit root_path
      sleep(2)
      fill_in 'Username', with: 'Bruce_Wayne'
      click_button 'Sign in'
      sleep(2)
      click_link 'Maria Foodie'
      sleep(2)
      page.find(:css, '.profile-info-picture-div a[rel="nofollow"]').click
      sleep(2)
      page.find(:css, '.vote-button-div a').click
      expect(page).to have_content('You voted for this recipe!')
      page.find(:css, '.vote-button-div a').click
      expect(page).to have_content('Vote for this recipe')
    end

    it 'allows user to see vote count of an opinion' do
      visit root_path
      sleep(2)
      fill_in 'Username', with: 'Bruce_Wayne'
      click_button 'Sign in'
      sleep(2)
      within('.create-new-opinion form') do
        fill_in 'opinion_text', with: 'This opinion is a test.'
        sleep(2)
        click_on 'SHARE'
      end
      sleep(3)
      page.find(:css, '.left-menu-link-profile').click
      sleep(2)
      page.find(:css, '.vote-button-div a').click
      sleep(2)
      page.click_link('', href: '/logout')
      sleep(2)
      fill_in 'Username', with: 'Maria_Foodie'
      click_button 'Sign in'
      sleep(2)
      click_link 'Bruce Wayne'
      sleep(2)
      page.find(:css, '.profile-info-picture-div a[rel="nofollow"]').click
      sleep(2)
      page.find(:css, '.vote-button-div a').click
      sleep(2)
      expect(page).to have_content('2 votes')
    end
  end
end
