class CompletedsController < TasksController
  # GET /tasks
  # GET /tasks.json
  # Completed Tasks tab
  def show
    @user = User.find(username: 'default').first
    # Completed tasks for this user
    @completed = true
    @tasks = @user.completed.all

    respond_to do |format|
      format.html { render 'tasks/index'}# index.html.erb
      format.json { render json: @tasks }
    end
  end
end
