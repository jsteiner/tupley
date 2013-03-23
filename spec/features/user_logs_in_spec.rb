require 'spec_helper'

feature 'User logs in' do
  scenario 'they see a sign out link' do
    sign_in
    expect(page).to have_content 'Sign out'
  end

  scenario 'they see a new task form' do
    sign_in
    expect(page).to have_css 'form#new_task'
  end
end
