class TasksController < ApplicationController
  def index
    @tasks = current_user.default_or_all_tasks
    @tags = current_user.tags
  end

  def create
    task = current_user.tasks.create(task_params)
    current_user.tag(task, with_names: params[:task][:tag_names])
    redirect_to :back, notice: 'Task saved successfully'
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update_attributes(task_params)
    current_user.tag(task, with_names: params[:task][:tag_names])
    redirect_to :back, notice: 'Task saved successfully'
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render nothing: true }
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
