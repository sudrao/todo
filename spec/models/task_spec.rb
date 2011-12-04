require 'spec_helper'

describe Task do
  before(:all) do
    @user = User.find(username: 'default').first
    @params = {title: 'Task 1', due_date: '2011-12-25'}
  end
    
  
  it "creates a valid task" do
    task = Task.new(@params)
    task.valid?.should be_true
    # task.errors.messages.should == nil
    task.save.should be_true
    (@user.pending << task).should be_true
  end
  
  def add_tasks
    3.times {|i| @user.pending << Task.create(title: "Task #{i}", due_date: '2011-12-24') }
  end
  
  it "finds tasks for a user" do
    add_tasks
    task1 = @user.pending[1]
    task1.should_not be_nil
    task1.title.should == "Task 1"
    tasks = @user.pending.all
    tasks.length.should == 3
  end
end