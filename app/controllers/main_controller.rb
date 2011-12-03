class MainController < ApplicationController
  
  def show
    @user = User.find_by_username('default')
    @task = @user.tasks.new # For a new task to be added
    # Pending tasks for this user
    @tasks = @user.tasks.where(complete: false)
  end
  
end
