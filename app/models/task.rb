class Task < Ohm::Model
  attribute :title
  attribute :due_date # YYYY-MM-DD
  
  def validate
    assert_present :title
    assert_present :due_date
    assert_format :due_date, /^\d{4}(-\d\d){2}$/
  end
end