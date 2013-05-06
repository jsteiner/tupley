require 'spec_helper'

describe TagFinder, '#to_tags' do
  it "returns only the user's existing tags for each tag name" do
    user = create(:user)
    tag = create(:tag, :shopping, user: user)
    create(:tag, :shopping)

    found_tags = TagFinder.new(user, 'shopping').to_tags

    expect(found_tags).to eq [tag]
  end

  it 'finds multiple tags' do
    user = create(:user)
    shopping_tag = create(:tag, :shopping, user: user)
    work_tag = create(:tag, :work, user: user)

    found_tags = TagFinder.new(user, 'shopping, work').to_tags

    expect(found_tags).to match_array [shopping_tag, work_tag]
  end

  it 'creates new tags if the user has no tags by the name' do
    user = create(:user)

    TagFinder.new(user, 'shopping').to_tags

    expect(user.tags.last.name).to eq 'shopping'
  end
end
