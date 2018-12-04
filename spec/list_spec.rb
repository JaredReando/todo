require 'spec_helper'

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns its name") do
      list = List.new({:name => "stuff", :id => nil})
      expect(list.name()).to(eq("stuff"))
    end
  end

  describe("#id") do
    it("sets its id when saved") do
      list = List.new({:name => "stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("saves list to the database") do
      list = List.new({:name => "stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same if the id and name match") do
      list1 = List.new({:name => "stuff", :id => nil})
      list2 = List.new({:name => "stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

  describe(".find_list") do
    it("resturns a list by its ID") do
      test_list1 = List.new({:name => "Jared stuff", :id => nil})
      test_list1.save()
      test_list2 = List.new({:name => "Other stuff", :id => nil})
      test_list2.save()
      expect(List.find_list(test_list1.id)).to(eq(test_list1))
    end
  end

  describe("#tasks") do
    it("resturns an array of tasks for that list") do
      test_list = List.new({:name => "Epicodus stuff", :id => nil})
      test_list.save()
      test_task = Task.new({:description => "Learn SQL", :list_id => test_list.id()})
      test_task.save()
      test_task2 = Task.new({:description => "Review Ruby", :list_id => test_list.id()})
      test_task2.save()
      expect(test_list.tasks()).to(eq([test_task, test_task2]))
    end
  end


end
