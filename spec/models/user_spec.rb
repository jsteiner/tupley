require 'spec_helper'

describe User, 'associations' do
  it { should have_many :tasks }
  it { should have_many :tags }
end

describe User, '#tag' do
  it 'tags the task with a single tag' do
    user = create(:user)
    tag = create(:tag, user: user)
    task = create(:task, user: user)

    user.tag(task, with: tag)

    expect(task.tags).to eq [tag]
  end

  it 'tags the task with multiple tags' do
    user = create(:user)
    tags = create_list(:tag, 2, user: user)
    task = create(:task, user: user)

    user.tag(task, with: tags)

    expect(task.tags).to match_array tags
  end

  it 'removes tags that are not in the tag list' do
    user = create(:user)
    removed_tag = create(:tag, user: user)
    added_tag = create(:tag, user: user)
    task = create(:task, user: user)

    user.tag(task, with: removed_tag)
    user.tag(task, with: added_tag)

    expect(task.tags).to eq [added_tag]
  end

  it 'does not raise when given duplicate tags' do
    user = create(:user)
    tag = create(:tag, user: user)
    task = create(:task, user: user)

    expect {
      user.tag(task, with: [tag, tag])
    }.not_to raise_error ActiveRecord::RecordInvalid
  end

  it 'only tags tasks that are owned by the user' do
    user = create(:user)
    tag = create(:tag, user: user)
    task = create(:task)

    user.tag(task, with: tag)

    expect(task.tags).to eq []
  end

  it 'only assigns tags that are owned by the user' do
    user = create(:user)
    tag = create(:tag)
    task = create(:task, user: user)

    user.tag(task, with: tag)

    expect(task.tags).to eq []
  end
end

describe User, '#default_or_all_tasks' do
  it 'returns default tasks if there are any default tags' do
    user = create(:user)
    default_tag = create(:default_tag, user: user)
    default_task = create(:task, user: user)
    non_default_task = create(:task, user: user)

    user.tag(default_task, with: default_tag)

    expect(user.default_or_all_tasks).to eq [default_task]
  end

  it 'returns all tasks if there are no default tags' do
    user = create(:user)
    tasks = create_list(:task, 2, user: user)

    expect(user.default_or_all_tasks).to match_array tasks
  end
end

describe User, '#default_tasks' do
  it 'returns only tasks for default tags' do
    user = create(:user)
    default_task = create(:task, user: user)
    non_default_task = create(:task, user: user)

    default_task.tags << create(:default_tag)

    expect(user.default_tasks).to eq [default_task]
  end
end

describe User, '#default_tags' do
  it 'returns only default tags' do
    user = create(:user)
    default_tag = create(:default_tag, user: user)
    non_default_tag = create(:tag, user: user)

    expect(user.default_tags).to eq [default_tag]
  end
end

describe User, '#default_tag_names' do
  it 'returns names of default tags' do
    user = create(:user)
    default_tag = create(:default_tag, user: user, name: 'work')
    default_tag = create(:default_tag, user: user, name: 'todo')
    non_default_tag = create(:tag, user: user)

    expect(user.default_tag_names).to include 'work'
    expect(user.default_tag_names).to include 'todo'
    expect(user.default_tag_names).to include ', '
  end
end

describe User, '#tasks_for' do
  it 'returns tasks for the given tag slugs' do
    user = create(:user)

    shopping_task = create(:task, user: user)
    shopping_task.tags << create(:tag, name: 'shopping')

    work_task = create(:task, user: user)
    work_task.tags << create(:tag, name: 'work')

    todo_task = create(:task, user: user)
    todo_task.tags << create(:tag, name: 'todo')

    no_tag_task = create(:task)

    expect(user.tasks_for(%w(shopping work)))
      .to match_array [shopping_task, work_task]
  end
end
