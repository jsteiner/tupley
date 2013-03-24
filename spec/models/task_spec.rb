require 'spec_helper'

describe Task, 'associations' do
  it { should belong_to :user }
end

describe Task, 'validations' do
  it { should validate_presence_of :name }
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
