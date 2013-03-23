require 'spec_helper'

describe User, 'associations' do
  it { should have_many :tasks }
end
