class Tag < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :taggings
  has_many :tasks, through: :taggings, uniq: true

  validates :name, :slug, presence: true

  friendly_id :name, use: :slugged

  def self.default
    where(default: true)
  end
end
