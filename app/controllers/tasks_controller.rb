class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @user = User.find(username: 'default').first
    unless @user
      @user = User.create(username: 'default', fullname: 'Default User')
    end
    puts "User id is #{@user.id}"
    @task = Task.new # For a new task to be added
    # Pending tasks for this user
    @tasks = @user.pending.all

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
      if @task.save && @user.pending << @task
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
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Todo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
