require 'pry'

class List
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all()
    lists = []
    rows = DB.exec("SELECT * FROM lists")
    rows.each do |row|
      name = row["name"]
      id = row["id"].to_i
      list = List.new({:name => name, :id => id})
      lists.push(list)
    end
    lists
  end

  def self.find_list(list_id)
    found_list = nil
    all_lists = List.all
    all_lists.each do |list|
      if list.id == list_id
        found_list = list
      end
    end
    found_list
  end

  def save
    values = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id")
    @id = values.first["id"].to_i
  end

  def tasks
    list_tasks = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id}")
    tasks.each do |task|
      description = task["description"]
      list_id = task["list_id"]
      list_tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    list_tasks
  end

  def ==(other)
    @name == other.name
  end
end
