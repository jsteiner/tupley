class NoneTagsController < ApplicationController
  def show
    @tasks = current_user.tasks_without_tags
    @tags = current_user.owned_tags
    render 'tasks/index'
  end
end
