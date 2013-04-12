class CompletedTasksController < ApplicationController
  def update
    task = current_user.tasks.find(params[:id])
    current_user.toggle_completion(task)
    redirect_to :back
  end
end
