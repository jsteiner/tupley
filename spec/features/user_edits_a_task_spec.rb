require 'spec_helper'

feature 'User edits a task spec', :js do
  scenario 'they see the updated task' do
    sign_in

    task = create_task

    task.edit do
      name 'New name'
      tags 'new tag'
    end

    expect(page).to have_css '.tasks li', text: 'New name'
    expect(task).to have_tag 'new tag'
  end

  scenario 'they see the description in markdown' do
    sign_in

    task = create_task

    task.edit do
      description "# Header\nDescription content"
    end

    expect(task).to have_css '.description h1', text: 'Header'
    expect(task).to have_css '.description p', text: 'Description content'
  end

  scenario 'they can not see more than one edit form at a time' do
    sign_in

    first_task = create_task { name 'Walk dog' }
    second_task = create_task { name 'Buy eggs' }

    first_task.click_edit_link
    second_task.click_edit_link

    expect(first_task).not_to be_editing
    expect(second_task).to be_editing
  end

  scenario 'they remain on the same page' do
    sign_in
    task = create_task { tags 'shopping' }
    visit '/tags/shopping'

    task.edit { name 'New name' }

    expect(current_path).to eq '/tags/shopping'
  end

  scenario 'they can cancel editing' do
    sign_in
    task = create_task { name 'Buy eggs' }
    task.click_edit_link

    task.cancel_edit

    expect(task).not_to be_editing
  end
end
