require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/restaurants')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/restaurants')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign Out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context 'if not signed in' do

   let!(:kfc){ Restaurant.create(name:'KFC') }

   it 'a restaurant cannot be created' do
      visit('/restaurants')
      click_link 'Edit KFC'
      expect(page).not_to have_button 'Update Restaurant'
    end
  end

  context 'user can only edit restaurants which they have created' do

    before do
      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')

      click_link 'add restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign Out'
    end

    scenario 'a user cannot edit a restaurant they did not create' do

      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link 'Edit KFC'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deletion limits' do

    before do

      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Sign Out')

      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Sign Out')

    end

    # let!(:user){ User.create(email: 'user@example.com')}
    # let!(:wrong_user){User.create(email: 'wrong_user@example.com')}

    scenario 'a user cannot delete a restaurant they did not create' do

      visit '/restaurants'
      click_link 'Sign in'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with:'testtest'
      click_button 'Log in'
      p current_path
      visit'/restaurants/new'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign Out'
      p current_path
      visit '/restaurants'
      click_link 'Sign in'
      fill_in 'Email', with: 'test2@example.com'
      fill_in 'Password', with:'testtest'
      click_button 'Log in'
      p current_path
      click_link 'Delete KFC'
      expect(page).not_to have_content 'deleted successfully'
    end
  end

end
