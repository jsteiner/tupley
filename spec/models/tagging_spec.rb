require 'spec_helper'

describe Tagging, 'associations' do
  it { should belong_to :tag }
  it { should belong_to :task }
end

describe Tagging, 'validations' do
  it { should validate_uniqueness_of(:tag_id).scoped_to(:task_id) }
end
