# frozen_string_literal: true

require 'test_helper'

describe TasksController do
  let (:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: Time.now + 5.days
  end

  # Tests for Wave 1
  describe 'index' do
    it 'can get the index path' do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it 'can get the root path' do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe 'show' do
    it 'can get a valid task' do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
    end
  end

  describe 'new' do
    it 'can get the new task page' do
      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new task' do
      # Arrange
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: nil
        }
      }

      # Act-Assert
      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.name).must_equal task_hash[:task][:name]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      # Act
      get edit_task_path(task.id)
      # Assert
      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      # Act
      get edit_task_path(-1)
      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
    end
  end

  describe 'update' do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it 'can update an existing task' do
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: nil
        }
      }

      patch task_path(task.id), params: task_hash
      must_respond_with :found
      must_redirect_to task_path(task.id)
    end

    it 'will redirect to the root page if given an invalid id' do
      patch task_path(-1)

      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'returns a 404 if the task is not found' do
      # Arrange
      invalid_id = 'NOT A VALID ID'

      # Act - Try to do the Books#destroy action
      expect do
        get task_path(invalid_id)
      end.wont_change 'Task.count'
    end

    it 'can delete a task' do
      # Arrange - Create a task
      new_task = Task.create(name: 'Destroy task')
      expect do
        # Act
        delete task_path(new_task.id)
        # Assert
      end.must_change 'Task.count', -1
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    it 'responds with a success message' do
      # Act/Assert
      post complete_task_path(task.id)
      must_respond_with :found
    end
  end
end
