require 'spec_helper'

feature 'User completes a task', :js do
  scenario 'they no longer see the task in the task list' do
    sign_in
    task = create_task
    task.complete

    expect(task).not_to be_visible
  end

  scenario 'they see the task in completed tasks' do
    sign_in
    task = create_task
    task.complete

    click_link 'completed'

    expect(task).to be_visible
  end

  scenario "they do not see the task on its other tag's page" do
    sign_in
    task = create_task { tag_list 'shopping' }
    task.complete

    click_link 'shopping'

    expect(task).not_to be_visible
  end
end
