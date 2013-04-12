class Task < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user

  validates :name, presence: true

  def self.complete
    includes(:tags).where(tags: { name: 'completed' })
  end

  def tag_list_string
    tags.map(&:name).join ', '
  end

  def incompleted_tag_list
    tags = tags_from(user)
    tags.delete('completed')
    tags.join(', ')
  end
end
