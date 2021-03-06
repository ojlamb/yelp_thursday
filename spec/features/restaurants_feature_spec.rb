require 'rails_helper'


feature 'restaurants' do

  before do
      visit('/restaurants')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'no restaurants yet'
      expect(page).to have_link 'add restaurant'
    end
  end
  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('no restaurants yet')
    end
  end
  context 'creating restaurants' do
    scenario 'prompts user to fill out the form and then displays the new restaurant' do
      visit '/restaurants'

      click_link 'add restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end
    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit'/restaurants'
        click_link 'add restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end
  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
  context 'editing restaurant' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'let a user edit a restaurant' do

      click_link 'add restaurant'
      fill_in 'Name', with: 'Starsucks'
      click_button 'Create Restaurant'

      visit '/restaurants'
      click_link 'Edit Starsucks'
      fill_in 'Name', with: 'Bad coffee'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Bad coffee'
      expect(current_path).to eq '/restaurants'

    end
  end
  context 'deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a delete link' do
      click_link 'add restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'

      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
