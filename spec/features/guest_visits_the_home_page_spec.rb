require 'spec_helper'

feature 'Guest visits the home page' do
  scenario 'they see the logo' do
    visit root_path
    expect(page).to have_css "[data-role='logo']", text: 'tupley'
  end

  scenario 'they see a sign in link' do
    visit root_path
    expect(page).to have_content 'Sign in'
  end

  scenario 'they do not see a new task form' do
    visit root_path
    expect(page).not_to have_css 'form#new_task'
  end
end
