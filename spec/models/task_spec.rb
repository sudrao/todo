require 'spec_helper'

describe Task do
  before(:all) do
    @user = User.find_by_username('default')
    @params = {title: 'Task 1', due_string: '2011-12-25', complete: false}
  end
    
  
  it "creates a valid task" do
    task = @user.tasks.new(@params)
    task.valid?.should be_true
    # task.errors.messages.should == nil
    task.save.should be_true
  end
end