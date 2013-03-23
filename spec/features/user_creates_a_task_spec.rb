require 'spec_helper'

feature 'User creates a task' do
  scenario 'they see the task on the page' do
    sign_in
    task = create_task
    expect(task).to be_visible
  end

  scenario "they see the task's tags" do
    sign_in

    task = create_task do
      tag_list 'shopping, purchases'
    end

    expect(task).to have_tag 'shopping'
    expect(task).to have_tag 'purchases'
  end

  scenario "they see the task's tags in the user's tag list" do
    sign_in

    task = create_task do
      tag_list 'shopping, purchases'
    end

    within 'ol.tags' do
      expect(page).to have_content 'shopping'
      expect(page).to have_content 'purchases'
    end
  end

  scenario "they can't create a 'none' tag" do
    sign_in

    task = create_task do
      tag_list 'none'
    end

    within 'ol.tags' do
      expect(page).to have_content 'shopping'
      expect(page).to have_content 'purchases'
    end
  end
end
