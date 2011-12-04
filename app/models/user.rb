class User < Ohm::Model
  attribute :username
  attribute :fullname
  list :pending, Task
  list :completed, Task
  index :username
  
  def validate
    assert_present :username
    assert_unique :username
  end
end
