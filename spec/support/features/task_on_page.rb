module Features
  def create_task(&block)
    task = TaskOnPage.new

    if block_given?
      task.instance_exec &block
    end

    task.create
  end

  class TaskOnPage
    include Capybara::DSL

    def create
      within '.new_task' do
        fill_in 'task_name', with: name_value
        fill_in 'task_tag_names', with: @tags
        click_button 'Create Task'
      end

      self
    end

    def edit(&block)
      click_edit_link

      instance_exec &block

      within '.edit_task' do
        fill_in 'task_name', with: name_value
        fill_in 'task_tag_names', with: @tags
        fill_in 'task_description', with: @description
        click_button 'save'
      end
    end

    def delete
      within task_element do
        click_link 'delete'
        click_link 'destroy'
      end
    end

    def click_edit_link
      within task_element do
        click_link 'edit'
      end
    end

    def cancel_edit
      find('.cancel-edit-link').click
    end

    def name(new_name)
      @name = new_name
    end

    def description(new_description)
      @description = new_description
    end

    def tags(new_tags)
      @tags = new_tags
    end

    def visible?
      task_list.has_css? 'li', text: name_value
    end

    def deleted?
      task_list.has_no_css? 'li', text: name_value
    end

    def has_tag?(tag)
      task_element.has_css? 'li', text: tag
    end

    def editing?
      task_dom_element.find('.edit_task').visible?
    end

    private

    def task_element
      task_list.find 'li', text: name_value
    end

    def task_dom_element
      find("li:contains('#{name_value}')")
    end

    def task_list
      find 'ol.tasks'
    end

    def name_value
      @name || 'Buy eggs'
    end
  end
end
