class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
    @tags = current_user.owned_tags
  end

  def create
    task = current_user.tasks.create(task_params)
    current_user.tag(task, with: tag_list, on: :tags)
    redirect_to :back, notice: 'Task saved successfully'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def tag_list
    params[:task][:tag_list]
  end
end
