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

    visit 'tags/completed'
    expect(task).to be_visible
  end

  scenario "they do not see the task on its tag's page" do

  end
end
