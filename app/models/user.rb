class User < ActiveRecord::Base
  include Clearance::User

  acts_as_tagger

  has_many :tasks

  def tasks_without_tags
    tasks.includes(:tags).where('taggings.taggable_id is NULL')
  end
end
