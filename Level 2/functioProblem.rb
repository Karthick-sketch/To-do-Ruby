# Problem 1: Fill-in the following code
#	write code so the program prints:
#		Hello Mr. Mandela
#		Welcome Mr. Turing

def salute(name, acknowledge) = "#{acknowledge.capitalize} Mr. #{name.split.last}"

puts salute("Nelson Rolihlahla Mandela", "hello")
puts salute("Sir Alan Turing", "welcome")