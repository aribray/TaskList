# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to action: 'index', status: 302
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(name: params[:task][:name], description: params[:task][:description], due_date: params[:task][:due_date]) # instantiate a new task
    if task.save # save returns true if the database insert succeeds
      redirect_to task_path(task.id) # go to the index so we can see the task in the list
    else # save failed :(
      render :show # show the new task form view again
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to action: 'index', status: 302
    end
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      flash[:error] = "Could not find task with id: #{params[:id]}"
      redirect_to tasks_path
    else @task.update_attributes(task_params)
         flash[:success] = 'Task Updated'
         redirect_to task_path(@task.id)
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])

    if task.nil?
      head :not_found
    else
      task.destroy
      redirect_to tasks_path
    end
  end

  def complete
    @task = Task.find_by(id: params[:id])
    if @task[:completed] == false
      @task[:completed] = true
      @task.completion_date = Time.now
    else
      @task[:completed] = false
      @task[:completion_date] = nil
    end
    flash[:success] = 'Status Updated'
    @task.save
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :completed, :completion_date)
  end
end
