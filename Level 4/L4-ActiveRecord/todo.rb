require "active_record"

# todo.rb
class Todo < ActiveRecord::Base
  def overdue?
    due_date < Date.today
  end

  def due_today?
    due_date == Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def self.overdue
    # Filter to-dos that are overdue
    all.filter { |todo| todo.overdue? }
  end

  def self.due_today
    # Filter to-dos that are due today
    all.filter { |todo| todo.due_today? }
  end

  def self.due_later
    # Filter to-dos that are due later
    all.filter { |todo| todo.due_later? }
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list(todos)
    todos.map { |todo| todo.to_displayable_string }.join("\n")
  end

  def self.show_list
    # print the list of todos
    puts ["My Todo-list",
          "Overdue\n" + to_displayable_list(overdue),
          "Due Today\n" + to_displayable_list(due_today),
          "Due Later\n" + to_displayable_list(due_later)].join("\n\n\n")
  end

  def self.add_task(hash)
    # take a Ruby hash as parameter, containing todo_text and due_in_days.
    Todo.create!(todo_text: hash[:todo_text], due_date: Date.today + hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    todo = Todo.find(id)
    # set its completed to true
    todo.completed = true; todo.save
    todo
  end
end
