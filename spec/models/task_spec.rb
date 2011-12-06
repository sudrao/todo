require 'spec_helper'

describe Task do
  before(:all) do
    @user = User.find(username: 'default').first
    @params = {title: 'Task 1', due_date: '2011-12-25'}
  end
    
  
  it "validates task parameters" do
    Task.create(due_date: '2011-12-24').errors.should == [[:title, :not_present]]
    Task.create(title: 'Task n').errors.should == [[:due_date, :not_present], [:due_date, :format]]
    Task.create(title: 'Task n1', due_date: '12-24-2011').errors.should == [[:due_date, :format]]
    Task.create(title: 'Task n1', due_date: '2011-12-24', finish_date: '12-24-2011').errors.should == [[:finish_date, :format]]
  end

  it "creates a valid task" do
    task = Task.new(@params)
    task.valid?.should be_true
    # task.errors.messages.should == nil
    task.save.should be_true
    (@user.pending << task).should be_true
  end
  
  def add_tasks(list, n=3)
    n.times {|i| list << Task.create(title: "Task #{i}", due_date: '2011-12-24') }
  end
  
  it "finds tasks for a user" do
    add_tasks(@user.pending)
    task1 = @user.pending[1]
    task1.should_not be_nil
    task1.title.should == "Task 1"
    tasks = @user.pending.all
    tasks.length.should == 3
  end
  
  it "paginates completed tasks" do
    add_tasks(@user.completed, 10)
    page_size = 4
    page0, ret_page, next_page = @user.get_completed_page({}, page_size)
    page0.length.should == page_size
    page1, ret_page, next_page = @user.get_completed_page({page: next_page}, page_size)
    page1.length.should == page_size
    page0[0].should_not == page1[0]
    page2, ret_page, next_page = @user.get_completed_page({page: next_page}, page_size)
    page2.length.should == 2
  end
  
end