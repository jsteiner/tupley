require 'spec_helper'

feature 'User sets default tags spec', :js do
  scenario 'they only see tasks with default tags' do
    sign_in

    shopping_task = create_task do
      name 'Buy eggs'
      tag_list 'shopping list'
    end

    work_task = create_task do
      name 'Get a raise'
      tag_list 'work'
    end

     movie_task = create_task do
       name 'See Argo'
       tag_list 'movies'
     end

    click_link 'set default tags'
    fill_in 'user_default_tag_list', with: 'shopping list, work'
    click_button 'Update default tags'

    expect(shopping_task).to be_visible
    expect(work_task).to be_visible
    expect(movie_task).not_to be_visible
  end

  scenario 'they see all tasks by setting it to an empty string' do
    sign_in

    shopping_task = create_task do
      name 'Buy eggs'
      tag_list 'shopping list'
    end

    work_task = create_task do
      name 'Get a raise'
      tag_list 'work'
    end

     movie_task = create_task do
       name 'See Argo'
       tag_list 'movies'
     end

    click_link 'set default tags'
    fill_in 'user_default_tag_list', with: ''
    click_button 'Update default tags'

    expect(shopping_task).to be_visible
    expect(work_task).to be_visible
    expect(movie_task).to be_visible
  end
end
