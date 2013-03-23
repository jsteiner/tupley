require 'spec_helper'

feature 'Guest visits the home page' do
  scenario 'they see the logo' do
    visit root_path
    expect(page).to have_css "[data-role='logo']", text: 'tupley'
  end
end
