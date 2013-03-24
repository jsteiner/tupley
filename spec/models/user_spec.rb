require 'spec_helper'

describe User, 'associations' do
  it { should have_many :tasks }
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
