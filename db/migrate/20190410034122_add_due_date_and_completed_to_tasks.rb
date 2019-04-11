class AddDueDateAndCompletedToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :due_date, :string
    add_column :tasks, :completed, :boolean
  end
end
