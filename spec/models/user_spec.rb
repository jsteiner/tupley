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
    task = create(:task)
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
