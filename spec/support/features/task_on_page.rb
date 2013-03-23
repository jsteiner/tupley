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
        fill_in 'task_tag_list', with: @tag_list
        click_button 'Create Task'
      end

      self
    end

    def delete
      within task_element do
        click_link 'delete'
        click_link 'destroy'
      end
    end

    def name(new_name)
      @name = new_name
    end

    def tag_list(new_tag_list)
      @tag_list = new_tag_list
    end

    def visible?
      task_list.has_css? 'li', text: name_value
    end

    def has_tag?(tag)
      task_element.has_css? 'li', text: tag
    end

    private

    def task_element
      task_list.find 'li', text: name_value
    end

    def task_list
      find 'ol.tasks'
    end

    def name_value
      @name || 'Buy eggs'
    end
  end
end
