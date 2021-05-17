def problem1(params) = params.map {|value| value.join(' ') }

def problem2(params1, params2) = params1.map.with_index {|value, index| value + " was written by " + params2[index]}

def problem3(params)
  arr = [];
  params.each {|value|
    title = arr.find {|x| x.first == value.last }
    if title
      arr[arr.index(title)].last << value.first
    else
      arr << [value.last, [value.first]]
    end
  }

  arr.map {|value| [value.first + ":", value.last.map {|x| "  " + x }] }.join("\n")
end


# Problem 1
names = [["Jhumpa", "Lahiri"], ["J. K", "Rowling"], ["Devdutt", "Pattanaik"]]
print "#{problem1(names)}\n\n"

# Problem 2
books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]
puts problem2(books, authors), ""

# Problem 3
todos = [
  ["Send invoice", "money"], ["Clean room", "organize"], ["Pay rent", "money"],
  ["Arrange books", "organize"], ["Pay taxes", "money"], ["Buy groceries", "food"]
]
puts problem3(todos)