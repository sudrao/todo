class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @user = User.find(username: 'default').first
    unless @user
      @user = User.create(username: 'default', fullname: 'Default User')
    end
    @task = Task.new # For a new task to be added
    # Pending tasks for this user
    @pending_tasks = @user.pending.all
    @completed_tasks = @user.completed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @user = User[params[:user_id]]
    
    respond_to do |format|
      if @task.save && @user.pending.unshift(@task)
        format.html { redirect_to action: 'index', notice: 'Todo was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { redirect_to action: 'index', error: 'Sorry, the todo could not be saved' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  # We get this when the user marks a todo complete
  # or wants to move it up or down in the pending list
  def update
    @task = Task[params[:id]]
    @user = User[params[:user_id]]
    pending_key = @user.pending.key
    # Remove from pending list and move it as instructed
    Ohm.redis.lrem(pending_key, 1, @task.id)

    case params[:do]
    when 'done'
      # Move the todo from pending to completed list
      updated = @user.completed.unshift(@task)
    when 'down'
      # Move it after the pivot
      updated = Ohm.redis.linsert(pending_key, :after, params[:pivot], @task.id)
    when 'up'
      updated = Ohm.redis.linsert(pending_key, :before, params[:pivot], @task.id)
    end
    
    respond_to do |format|
      if updated
        format.html { redirect_to action: 'index', notice: 'Todo was updated.' }
        format.json { head :ok }
      else
        format.html { redirect_to action: 'index', error: 'Operation failed.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task[params[:id]]
    id = @task.id
    @task.delete
    # Also remove from the pending and completed lists
    @user = User[params[:user_id]]
    Ohm.redis.lrem(@user.pending.key, 1, id)
    Ohm.redis.lrem(@user.completed.key, 1, id)
    
    respond_to do |format|
      format.html { redirect_to action: 'index', notice: 'Todo was deleted.' }
      format.json { head :ok }
    end
  end
end
