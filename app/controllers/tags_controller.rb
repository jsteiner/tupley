class TagsController < ApplicationController
  def show
    @tasks = current_user.tasks_for(tag_slugs)

    if @tasks.any?
      @tags = current_user.tags
      render 'tasks/index'
    else
      raise ActionController::RoutingError.new 'No tags exist by that name'
    end
  end

  private

  def tag_slugs
    params[:tags].split('+')
  end
end
