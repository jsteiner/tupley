class DefaultTagsController < ApplicationController
  def update
    current_user.update_attributes(default_tag_list)

    redirect_to :back
  end

  private

  def default_tag_list
    params.require(:user).permit(:default_tag_list)
  end
end
