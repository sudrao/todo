class PendingsController < TasksController
  # GET /tasks
  # GET /tasks.json
  # Pending Tasks tab
  def show
    @user = User.find(username: 'default').first
    unless @user
      @user = User.create(username: 'default', fullname: 'Default User')
    end
    puts "User id is #{@user.id}"
    @task = Task.new # For a new task to be added
    # Pending tasks for this user
    @completed = false
    @tasks = @user.pending.all

    respond_to do |format|
      format.html { render 'tasks/index'}# index.html.erb
      format.json { render json: @tasks }
    end
  end
end

