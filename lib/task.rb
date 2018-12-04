require'pry'

class Task
  attr_reader(:description, :list_id)

  def initialize(attributes)
    @description = attributes[:description]
    @list_id = attributes[:list_id]
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task["description"]
      list_id = task["list_id"].to_i
      tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  def ==(other)
    @description == other.description && @list_id == other.list_id
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

end
