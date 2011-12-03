class Task < ActiveRecord::Base
  belongs_to :user
  # We get due date as a string on create
  attr_accessor :due_string
  # which we convert to a date object
  before_create :convert_due
  
  validates_presence_of :title
  validates_presence_of :due_string
  validates_format_of :due_string, with: /\A\d{4}(-\d\d){2}\Z/
  
  def convert_due
    due = Date.parse(due_string) if due_string
  end
end