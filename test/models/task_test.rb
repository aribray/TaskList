require "test_helper"

describe Task do
  let(:task) { Task.new }

  it "must be valid" do
    value(task).must_be :valid?
  end
end
