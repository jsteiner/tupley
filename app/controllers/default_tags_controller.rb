class DefaultTagsController < ApplicationController
  def update
    current_user.set_default_tags default_tag_names

    redirect_to :back
  end

  private

  def default_tag_names
    params[:user][:default_tag_names].split(',').map(&:strip)
  end
end
