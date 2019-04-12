# frozen_string_literal: true

class ChangeDataTypeOfDueDate < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :due_date, 'date USING CAST(due_date AS date)')
  end
end
