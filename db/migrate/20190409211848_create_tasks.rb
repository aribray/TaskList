class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :completion_date

      t.timestamps
    end
  end
end
