require 'spec_helper'

feature 'User views tasks with no tags' do
  scenario 'they only see tasks with no tags' do
    sign_in

    task_without_tags = create_task

    task_with_tags = create_task do
      name 'Buy Cake'
      tag_list 'shopping'
    end

    within 'ol.tags' do
      click_link 'none'
    end

    expect(task_without_tags).to be_visible
    expect(task_with_tags).not_to be_visible
  end
end
