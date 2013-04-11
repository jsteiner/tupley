require 'spec_helper'

feature 'User deletes a task via ajax', :js do
  scenario 'they no longer see the task' do
    sign_in

    task = create_task { name 'Buy eggs' }
    task.delete

    expect(task).to be_deleted
  end
end

feature 'User deletes a task' do
  scenario 'they no longer see the task' do
    sign_in

    task = create_task { name 'Buy eggs' }
    task.delete

    expect(task).to be_deleted
  end
end
