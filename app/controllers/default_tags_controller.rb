class DefaultTagsController < ApplicationController
  def update
    current_user.tags.update_all(default: false)
    current_user.tags.where(name: default_tag_names).update_all(default: true)

    redirect_to :back
  end

  private

  def default_tag_names
    params[:user][:default_tag_names].split(',').map(&:strip)
  end
end
