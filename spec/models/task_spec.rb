require 'spec_helper'

describe Task, 'associations' do
  it { should belong_to :user }
  it { should have_many :taggings }
  it { should have_many(:tags).through(:taggings) }
end

describe Task, 'validations' do
  it { should validate_presence_of :name }
end

describe Task, '.with_default_tags' do
  it 'returns tasks that have default tags' do
    default_task = create(:task)
    non_default_task = create(:task)

    default_task.tags << create(:tag, :default)

    expect(Task.with_default_tags).to eq [default_task]
  end
end

describe Task, '#tag_names' do
  it "returns a comma delimited set of the task's tags" do
    task = create(:task)
    task.tags << create(:tag, name: 'hello')
    task.tags << create(:tag, name: 'world')
    task.tags << create(:tag, name: 'tag list')
    task.tags << create(:tag, name: 'hello')

    expect(task.tag_names).to include 'hello'
    expect(task.tag_names).to include 'world'
    expect(task.tag_names).to include 'tag list'
    expect(task.tag_names).to include ', '
  end
end
