require 'spec_helper'

describe Task, 'associations' do
  it { should belong_to :user }
end

describe Task, 'validations' do
  it { should validate_presence_of :name }
end

describe Task, '.complete' do
  it 'only returns tasks with the complete tag' do
    user = create(:user)
    complete_task_1 = create(:task, user: user)
    incomplete_task_1 = create(:task, user: user)
    complete_task_2 = create(:task, user: user)
    incomplete_task_2 = create(:task, user: user)

    user.tag(complete_task_1, with: 'hello, completed', on: :tags)
    user.tag(incomplete_task_1, with: 'hello', on: :tags)
    user.tag(complete_task_2, with: 'completed', on: :tags)

    expect(user.tasks.complete)
      .to match_array [complete_task_1, complete_task_2]
  end
end

describe Task, '#tag_list_string' do
  it "returns a comma delimited set of the task's tags" do
    user = create(:user)
    task = create(:task)

    user.tag(task, with: 'hello, world, tag list', on: :tags)

    expect(task.tag_list_string).to include 'hello'
    expect(task.tag_list_string).to include 'world'
    expect(task.tag_list_string).to include 'tag list'
    expect(task.tag_list_string).to include ', '
  end
end

describe Task, '#incompleted_tag_list' do
  it "returns the tag list without 'completed'" do
    user = create(:user)
    task = create(:task, user: user)

    user.tag(task, with: 'hello, world, completed', on: :tags)

    expect(task.incompleted_tag_list).to include 'hello'
    expect(task.incompleted_tag_list).to include 'world'
    expect(task.incompleted_tag_list).not_to include 'completed'
  end
end
