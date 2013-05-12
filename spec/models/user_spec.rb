require 'spec_helper'

describe User, 'associations' do
  it { should have_many :tasks }
  it { should have_many :tags }
end

describe User, '#tag' do
  it 'tags the task with a single tag' do
    user = create(:user)
    work_tag = create(:tag, :work, user: user)
    task = create(:task, user: user)

    user.tag(task, with: 'work')

    expect(task.tags).to eq [work_tag]
  end

  it 'tags the task with multiple tags' do
    user = create(:user)
    work_tag = create(:tag, :work, user: user)
    todo_tag = create(:tag, :todo, user: user)
    task = create(:task, user: user)

    user.tag(task, with: 'work, todo')

    expect(task.tags).to match_array [work_tag, todo_tag]
  end

  it 'removes tags that are not in the tag list' do
    user = create(:user)
    todo_tag = create(:tag, :todo, user: user)
    work_tag = create(:tag, :work, user: user)
    task = create(:task, user: user)

    user.tag(task, with: 'todo')
    user.tag(task, with: 'work')

    expect(task.tags).to eq [work_tag]
  end

  it 'does not raise when given duplicate tags' do
    user = create(:user)
    work_tag = create(:tag, :work, user: user)
    task = create(:task, user: user)

    expect {
      user.tag(task, with: 'work, work')
    }.not_to raise_error ActiveRecord::RecordInvalid
  end

  it 'only tags tasks that are owned by the user' do
    user = create(:user)
    tag = create(:tag, :work, user: user)
    task = create(:task)

    user.tag(task, with: 'work')

    expect(task.tags).to eq []
  end

  it 'only assigns tags that are owned by the user' do
    user = create(:user)
    tag = create(:tag, :work)
    task = create(:task, user: user)

    user.tag(task, with: 'work')

    expect(task.tags).not_to include tag
  end

  it 'assigns a tag of none if there are no tags' do
    user = create(:user)
    task = create(:task, user: user)

    user.tag(task, with: '')

    expect(task.tags.first.name).to eq 'none'
  end

  it "creates a new tag if it doesn't exist" do
    user = create(:user)
    task = create(:task, user: user)

    user.tag(task, with: 'work')

    expect(task.tags.first.name).to eq 'work'
  end

  it 'strips out blank tag names' do
    user = create(:user)
    work_tag = create(:tag, :work, user: user)
    todo_tag = create(:tag, :todo, user: user)
    task = create(:task, user: user)

    user.tag(task, with: 'work, , todo')

    expect(task.tags).to match_array [work_tag, todo_tag]
  end
end

describe User, '#set_default_tags' do
  it "updates the user's default tags" do
    user = create(:user)
    original_default_tag = create(:tag, :default, user: user)

    shopping_tag = create(:tag, :shopping, user: user)
    work_tag = create(:tag, :work, user: user)

    user.set_default_tags %w(shopping work)

    expect(shopping_tag.reload.default).to be_true
    expect(work_tag.reload.default).to be_true
    expect(original_default_tag.reload.default).to be_false
  end

  it "does not update another user's defaults" do
    user = create(:user)
    work_tag = create(:tag, :work, user: user)
    other_user_work_tag = create(:tag, :work)

    user.set_default_tags %w(work)

    expect(work_tag.reload.default).to be_true
    expect(other_user_work_tag.reload.default).to be_false
  end

  it "updates the user's tags to no defaults" do
    user = create(:user)
    default_tag = create(:tag, :default, user: user)

    user.set_default_tags []

    expect(default_tag.reload.default).to be_false
  end
end

describe User, '#default_or_all_tasks' do
  it 'returns default tasks if there are any default tags' do
    user = create(:user)
    default_tag = create(:tag, :default, :work, user: user)
    default_task = create(:task, user: user)
    non_default_task = create(:task, user: user)

    user.tag(default_task, with: 'work')

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

    default_task.tags << create(:tag, :default)

    expect(user.default_tasks).to eq [default_task]
  end
end

describe User, '#default_tags' do
  it 'returns only default tags' do
    user = create(:user)
    default_tag = create(:tag, :default, user: user)
    non_default_tag = create(:tag, user: user)

    expect(user.default_tags).to eq [default_tag]
  end
end

describe User, '#default_tag_names' do
  it 'returns names of default tags' do
    user = create(:user)
    create(:tag, :shopping, user: user)

    create(:tag, :default, :work, user: user)
    create(:tag, :default, :todo, user: user)

    expect(user.default_tag_names).not_to include 'shopping'
    expect(user.default_tag_names).to include 'work'
    expect(user.default_tag_names).to include 'todo'
    expect(user.default_tag_names).to include ', '
  end
end

describe User, '#tasks_for' do
  it 'returns tasks for the given tag slugs' do
    user = create(:user)

    shopping_task = create(:task, user: user)
    shopping_task.tags << create(:tag, :shopping)

    work_task = create(:task, user: user)
    work_task.tags << create(:tag, :work)

    todo_task = create(:task, user: user)
    todo_task.tags << create(:tag, :todo)

    no_tag_task = create(:task)

    expect(user.tasks_for(%w(shopping work)))
      .to match_array [shopping_task, work_task]
  end
end
