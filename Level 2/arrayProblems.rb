def problem1(params) = params.map {|value| value.join(' ') }

def problem2(params1, params2) = params1.map.with_index {|value, index| value + " was written by " + params2[index]}

def problem3(params)
	arr = [];
	params.each do |value|
		title = arr.find {|x| x.first == value.last }
		if title
			arr[arr.index(title)].last << value.first
		else
			arr << [value.last, [value.first]]
		end
	end
	arr.map {|value| [value.first + ":", value.last.map {|x| "  " + x }] }.join("\n")
end


# Problem 1: Given a nested array of first names and last names, return a new array with the full names.
names = [["Jhumpa", "Lahiri"], ["J. K", "Rowling"], ["Devdutt", "Pattanaik"]]
print "#{problem1(names)}\n\n"


# Problem 2: Given two arrays books and authors, merge them and print who wrote which book.
books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]
puts problem2(books, authors), ""


# Problem 3: Print the given list of todos by category.
todos = [
	["Send invoice", "money"], ["Clean room", "organize"], ["Pay rent", "money"],
	["Arrange books", "organize"], ["Pay taxes", "money"], ["Buy groceries", "food"]
]
puts problem3(todos)