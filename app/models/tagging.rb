class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :task

  validates :tag_id, uniqueness: { scope: :task_id }
end
