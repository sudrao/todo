class MainController < ApplicationController
  
  def show
    @user = User.find_by_username('default')
    @tasks = @user.tasks.where(complete: false)
  end
  
end
