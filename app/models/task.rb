class Task < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user

  validates :name, presence: true

  def tag_list_string
    tags.map(&:name).join ', '
  end
end
