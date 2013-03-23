require 'spec_helper'

describe Task, 'associations' do
  it { should belong_to :user }
end

describe Task, 'validations' do
  it { should validate_presence_of :name }
end
