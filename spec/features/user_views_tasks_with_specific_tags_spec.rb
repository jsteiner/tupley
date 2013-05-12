require 'spec_helper'

feature 'User views tasks with specific tags' do
  scenario 'they see tasks for parameterized tags' do
    sign_in

    create_task do
      name 'Buy eggs'
      tags 'shopping list'
    end

    within 'ol.tags' do
      click_on 'shopping list'
    end

    expect(page).to have_content 'Buy eggs'
  end

  scenario 'they see tasks for the multiple tags at once' do
    sign_in

    create_task do
      name 'Buy eggs'
      tags 'shopping'
    end

    create_task do
      name 'Write presentation'
      tags 'work'
    end

    create_task do
      name 'Read a book'
      tags 'other'
    end

    visit 'tags/shopping+work'

    expect(page).to have_content 'Buy eggs'
    expect(page).to have_content 'Write presentation'
    expect(page).not_to have_content 'Read a book'
  end

  scenario 'they see a 404 if the tag does not exist' do
    sign_in

    expect {
      visit 'tags/nonexistant-tag'
    }.to raise_error(ActionController::RoutingError)
  end

  scenario 'they see a 404 if the tag does not belong to them' do
    sign_in

    task = create(:task)
    task.tags << create(:tag, name: 'other users tag')

    expect {
      visit 'tags/other-users-tag'
    }.to raise_error(ActionController::RoutingError)
  end
end
