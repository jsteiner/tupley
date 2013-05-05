class User < ActiveRecord::Base
  include Clearance::User

  has_many :tasks
  has_many :tags

  def tag(task, with: nil, with_names: nil)
    if with.present?
      new_tags = [*with]
      if own?(task) && own?(new_tags)
        begin
          task.tags = new_tags
        rescue ActiveRecord::RecordInvalid
        end
      end
    else
      begin
        task.tags = TagFinder.new(self, with_names).to_tags
      rescue ActiveRecord::RecordInvalid
      end
    end
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
