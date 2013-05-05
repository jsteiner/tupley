class TagFinder
  def initialize(user, names)
    @user = user

    if names.present?
      @names = names.split(',').map(&:strip)
    else
      @names = %w(none)
    end
  end

  def to_tags
    create_new_tags
    @user.tags.where(name: @names)
  end

  private

  def create_new_tags
    new_tag_names.each do |name|
      Tag.create(name: name, user_id: @user.id)
    end
  end

  def existing_tags
    @existing_tags ||= @user.tags.where(name: @names)
  end

  def existing_tag_names
    @existing_tag_names ||= existing_tags.map(&:name)
  end

  def new_tag_names
    @names - existing_tag_names
  end
end
