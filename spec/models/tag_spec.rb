require 'spec_helper'

describe Tag, 'associations' do
  it { should belong_to :user }
  it { should have_many :taggings }
  it { should have_many(:tasks).through(:taggings) }
end

describe Tag, '.default' do
  it 'returns only default tags' do
    default_tag = create(:default_tag)
    non_default_tag = create(:tag)

    expect(Tag.default).to eq [default_tag]
  end
end
