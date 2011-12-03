class Task < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :due
  validates_format_of :due, with: /\A(\d\d-){2}\d{4}\Z/
end