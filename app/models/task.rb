class Task < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user

  validates :name, presence: true
end
