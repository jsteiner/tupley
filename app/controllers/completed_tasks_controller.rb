class CompletedTasksController < ApplicationController
  def update
    task = current_user.tasks.find(params[:id])
    current_user.tag(task, with: "#{task.tag_list_string}, completed", on: :tags)
    redirect_to :back
  end
end
