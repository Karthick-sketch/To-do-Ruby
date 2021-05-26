require "active_record"

# todo.rb
class Todo < ActiveRecord::Base
  def overdue?
    due_date < Date.today # check the to-do is overdue or not
  end

  def due_today?
    due_date == Date.today # check the to-do is today or not
  end

  def due_later?
    due_date > Date.today # check the to-do is later day or not
  end

  def self.overdue
    all.filter { |todo| todo.overdue? }
    # puts all.first.overdue?
  end

  def self.due_today
    all.filter { |todo| todo.due_today? }
  end

  def self.due_later
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
    # prints the list of todos as per the above format.
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts to_displayable_list(overdue)
    puts "\n\n"

    puts "Due Today\n"
    puts to_displayable_list(due_today)
    puts "\n\n"

    puts "Due Later\n"
    puts to_displayable_list(due_later)
    puts "\n\n"
  end

  def self.add_task(hash)
    # it will take a Ruby hash as parameter, containing todo_text and due_in_days.
    Todo.create!(todo_text: hash[:todo_text], due_date: Date.today + hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    # set its completed to true
    todo = Todo.find(id)
    todo.completed = true
    todo.save
    todo
  end
end
