require "active_record"

# todo.rb
class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def self.overdue
    # get to-dos from database that are overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    # get to-dos from database that are due today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    # get to-dos from database that are due later
    where("due_date > ?", Date.today)
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }.join("\n")
  end

  def self.show_list
    # print the list of todos
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts overdue.to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.to_displayable_list
    puts "\n\n"
  end

  def self.add_task(hash)
    # take a Ruby hash as parameter, containing todo_text and due_in_days.
    Todo.create!(todo_text: hash[:todo_text], due_date: Date.today + hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    todo = Todo.find(id)
    # set its completed to true
    todo.completed = true; todo.save!
    todo
  end
end
