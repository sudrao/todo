module ButtonHelper
  # Strings to generate buttons
  def undo_span
    '<span class="ui-icon ui-icon-circle-check"></span>'.html_safe
  end
  
  def done_span
    '<span class="ui-icon ui-icon-check"></span>'.html_safe
  end
  
  def up_span
    '<span class="ui-icon ui-icon-arrowthick-1-n"></span>'.html_safe
  end
  
  def down_span
    '<span class="ui-icon ui-icon-arrowthick-1-s"></span>'.html_safe
  end
  
  def del_span
    '<span class="ui-icon ui-icon-trash"></span>'.html_safe
  end
  
  def button_class
    'fg-button ui-state-default fg-button-icon-solo ui-corner-all'
  end
  
  def button_class_py
     button_class + ' ui-priority-primary'
  end
  
  def button_class_sy
    button_class + ' ui-priority-secondary'
  end
  
  def task_user_path(task, user)
    "/tasks/#{task.id}?user_id=#{user.id}"
  end
  
  def undo_path(task, user)
    (task_user_path(task, user) + "&do=undo")
  end
  
  def done_path(task, user)
    (task_user_path(task, user) + "&do=done")
  end

  def up_path(task, user, prev)
    (task_user_path(task, user) + "&do=up&pivot=#{prev.id}")
  end

  def down_path(task, user, after)
    (task_user_path(task, user) + "&do=down&pivot=#{after.id}")
  end
end