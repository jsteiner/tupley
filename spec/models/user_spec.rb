require 'spec_helper'

describe User, 'associations' do
  it { should have_many :tasks }
end

describe User, '.complete_tasks' do
  it "only returns the user's tasks with the complete tag" do
    user = create(:user)
    complete_task = create(:task, user: user)
    incomplete_task = create(:task, user: user)
    not_my_task = create(:task)

    user.tag(complete_task, with: 'hello, completed', on: :tags)
    user.tag(incomplete_task, with: 'hello', on: :tags)
    user.tag(not_my_task, with: 'completed', on: :tags)

    expect(user.complete_tasks).to eq [complete_task]
  end
end

describe User, '#tasks_without_tags' do
  it 'returns tasks with no tags' do
    user = create(:user)
    task = create(:task, user: user)

    expect(user.tasks_without_tags).to eq [task]
  end

  it 'does not return tasks with tags' do
    user = create(:user)
    task = create(:task, user: user)
    user.tag(task, with: 'shopping', on: :tags)

    expect(user.tasks_without_tags).to eq []
  end

  it "does not return other user's tags" do
    user = create(:user)
    task = create(:task)
    create(:user).tag(task, with: 'shopping', on: :tags)

    expect(user.tasks_without_tags).to eq []
  end
end

describe User, '#default_tasks' do
  it 'returns only tasks for default tags' do
    user = create(:user, default_tag_list: 'shopping')

    default_task = create(:task, user: user)
    user.tag(default_task, with: 'shopping', on: :tags)

    non_default_task = create(:task, user: user)
    user.tag(non_default_task, with: 'work', on: :tags)

    expect(user.default_tasks).to eq [default_task]
  end

  it 'returns tasks for multiple tags' do
    user = create(:user, default_tag_list: 'shopping, work')

    shopping_task = create(:task, user: user)
    user.tag(shopping_task, with: 'shopping', on: :tags)

    work_task = create(:task, user: user)
    user.tag(work_task, with: 'work', on: :tags)

    expect(user.default_tasks).to match_array [shopping_task, work_task]
  end

  it 'returns all tasks if no defaults are set' do
    user = create(:user, default_tag_list: '')
    task = create(:task, user: user)
    user.tag(task, with: 'shopping', on: :tags)

    expect(user.default_tasks).to eq [task]
  end
end

describe User, '#toggle_completion' do
  it 'toggles the complete tag on the task' do
    user = create(:user)
    task = create(:task, user: user)
    user.tag(task, with: 'hello', on: :tags)
    expect(task.tags_from user).not_to include 'completed'
    user.toggle_completion(task)
    expect(task.tags_from user).to include 'completed'
    user.toggle_completion(task)
    expect(task.tags_from user).not_to include 'completed'
  end
end
