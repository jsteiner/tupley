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
        click_button 'Create Task'
      end

      self
    end

    def name(new_name)
      @name = new_name
    end

    def visible?
      task_list.has_css? 'li', text: name_value
    end

    private

    def task_list
      find 'ol.tasks'
    end

    def name_value
      @name || 'Buy eggs'
    end
  end
end
