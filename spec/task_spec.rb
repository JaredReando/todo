require 'spec_helper'

describe(Task) do
  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL"})
      task2 = Task.new({:description => "learn SQL"})
      expect(task1).to(eq(task2))
    end
  end

  describe("#save") do
    it("returns all tasks in DB table") do
      list1 = List.new({:name => "things"})
      list1.save
      values = DB.exec("SELECT id FROM lists WHERE name = 'things'")
      value_id = values[0]["id"].to_i
      task1 = Task.new({:description => "learn SQL", :list_id => value_id})
      task2 = Task.new({:description => "learn SQL", :list_id => value_id})
      task1.save
      task2.save
      expect(Task.all).to(eq([task1, task2]))
    end
  end
end
