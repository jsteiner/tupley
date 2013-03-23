class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def create
    current_user.tasks.create(task_params)
    redirect_to :back, notice: 'Task saved successfully'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
