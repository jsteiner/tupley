class TagsController < ApplicationController
  def show
    @tasks = tasks_for(tag_slugs)

    if @tasks.any?
      @tags = current_user.owned_tags
      render 'tasks/index'
    else
      raise ActionController::RoutingError.new 'No tags exist by that name'
    end
  end

  private

  def tag_slugs
    params[:tags].split('+')
  end

  def tasks_for(tag_slugs)
    Task.tagged_with_slugs(
      tag_slugs,
      on: :tags,
      owned_by: current_user,
      any: true
    )
  end
end
