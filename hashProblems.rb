def problem1(params1, params2)
	hash = {}
	params2.each.with_index do |value, index|
		hash[value.slice(0, value.index(" ")).downcase.to_sym] = params1[index]
	end
	return hash
end


def problem2(params)
	hash = {}
	params.each do |value|
		key = value.last.to_sym
		if hash.keys.include? key
			hash[key] << value.first
		else
			hash[key] = [value.first]
		end
	end
	return hash
end


# Problem 1:
#	Given two arrays books and authors, merge them into a single Hash. The keys of the Hash must be
# the lower-cased firstname of the authors, and must be symbols.
books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]
puts problem1(books, authors)


# Problem 2:
#	Given this list of todos, create a Hash keyed by category, whose value is an array containing
# all the todos in that category. The keys of the Hash must be a symbol.
todos = [
	["Send invoice", "money"], ["Clean room", "organize"], ["Pay rent", "money"],
	["Arrange books", "organize"], ["Pay taxes", "money"], ["Buy groceries", "food"]
]
puts problem2(todos)