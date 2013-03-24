class User < ActiveRecord::Base
  include Clearance::User

  acts_as_tagger

  has_many :tasks

  def tasks_without_tags
    tasks.includes(:tags).where('taggings.taggable_id is NULL')
  end

  def default_tasks
    if default_tag_list.empty?
      tasks
    else
      Task.tagged_with(
        default_tag_list,
        on: :tags,
        owned_by: self,
        any: true
      )
    end
  end
end
