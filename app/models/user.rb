class User < Ohm::Model
  attribute :username
  attribute :fullname
  list :pending, Task
  list :completed, Task
  index :username
  
  def validate
    assert_present :username
    assert_unique :username
  end
  
  # Get one page of tasks from completed list
  # Returns tasks, current and next page number
  def get_completed_page(params, page_size)
    page = 0
    if params[:page]
      page = params[:page].to_i
      offset = page * page_size
      # Return current page unless page 0
      ret_page = page if page > 0
    else
      offset = 0
    end
    tasks = self.completed[offset, offset + page_size -1] # limit to 50
    # retur next_page if there are more tasks
    next_page = page + 1 if self.completed[offset + page_size]
    return tasks, ret_page, next_page
  end
end
