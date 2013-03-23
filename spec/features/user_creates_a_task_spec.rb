require 'spec_helper'

feature 'User creates a task' do
  scenario 'they see the task on the page' do
    sign_in
    task = create_task
    expect(task).to be_visible
  end
end
