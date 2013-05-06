class User < ActiveRecord::Base
  include Clearance::User

  has_many :tasks
  has_many :tags

  def tag(task, with: nil)
    if task.user == self
      task.tags = TagFinder.new(self, with).to_tags
    end
  end

  def set_default_tags(tag_names)
    default_tags.update_all(default: false)
    tags.where(name: tag_names).update_all(default: true)
  end

  def default_or_all_tasks
    if default_tags.any?
      default_tasks
    else
      tasks
    end
  end

  def default_tasks
    tasks.with_default_tags
  end

  def default_tags
    tags.default
  end

  def default_tag_names
    tags.default.map(&:name).join ', '
  end

  def tasks_for(tag_slugs)
    tasks.joins(:tags).where(tags: { slug: tag_slugs })
  end

  private

  def own?(items)
    [*items].map(&:user).uniq == [self]
  end
end
