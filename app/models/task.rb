class Task < Ohm::Model
  attribute :title
  attribute :due_date # YYYY-MM-DD
  attribute :finish_date # YYYY-MM-DD
  
  def validate
    assert_present :title
    assert_present :due_date
    assert_format :due_date, /^\d{4}(-\d\d){2}$/
    if self.finish_date
      assert_format :finish_date, /^\d{4}(-\d\d){2}$/
    end
  end
end