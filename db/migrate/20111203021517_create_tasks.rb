class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :due
      t.boolean :complete
      t.integer :user_id

      t.timestamps
    end
  end
end
