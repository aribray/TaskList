class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil? 
      flash[:error] = "Could not find task with id: #{task_id}"
      redirect_to action: "index", status: 302
    end
    
  end

  def new
    @task = Task.new
  end


  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description]) #instantiate a new book
    if @task.save # save returns true if the database insert succeeds
      redirect_to root_path # go to the index so we can see the book in the list
    else # save failed :(
      render :new # show the new book form view again
    end
  end
  
end
