class Task < ActiveRecord::Base
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, uniq: true

  validates :name, presence: true

  def self.with_default_tags
    joins(:tags).where(tags: { default: true })
  end

  def tag_names
    tags.map(&:name).join ', '
  end
end
