class User < ActiveRecord::Base
  include Clearance::User

  acts_as_tagger

  has_many :tasks

  def complete_tasks
    tasks.complete
  end

  def incomplete_tasks
    if tasks.complete.any?
      tasks.where('id not in (?)', complete_tasks)
    else
      tasks
    end
  end

  def tasks_without_tags
    tasks.includes(:tags).where('taggings.taggable_id is NULL')
  end

  def default_tasks
    if default_tag_list.empty?
      incomplete_tasks
    else
      Task.tagged_with(
        default_tag_list,
        on: :tags,
        owned_by: self,
        any: true
      )
    end
  end

  def toggle_completion(task)
    if task.tags_from(self).include? 'completed'
      incomplete task
    else
      complete task
    end
  end

  private

  def complete(task)
    tag(task, with: "#{task.tag_list_string}, completed", on: :tags)
  end

  def incomplete(task)
    tag(task, with: "#{task.incompleted_tag_list}", on: :tags)
  end
end
