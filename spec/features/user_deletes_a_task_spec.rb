require 'spec_helper'

feature 'User deletes a task', :js do
  scenario 'they no longer see the task' do
    sign_in

    create_task { name 'Bake cake' }

    task = create_task { name 'Buy eggs' }
    task.delete

    expect(task).not_to be_visible
  end
end
