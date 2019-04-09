class TasksController < ApplicationController
  TASKS = [
    {name: 'Go to the store', day_due: 'Monday'},
    {name: 'File taxes', day_due: 'Wednesday'},
    {name: 'Buy cat food and litter', day_due: 'Friday'},
    {name: 'Buy ferry ticket to Victoria', day_due: 'Saturday'}
  ]

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
    end
  end
end
