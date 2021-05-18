def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

# ..
# ..
# FILL YOUR CODE HERE

def resolve(records, lookup_chain, domain)
  if records[records.keys.first].keys.include? domain
    # push source value of the A record into 'lookup_chain' array
    # and return the 'lookup_chain' array
    lookup_chain << records[records.keys.first][domain]
  elsif records[records.keys.last].keys.include? domain
    # store source value of the CNAME record into 'domain' variable
    # and push it to the 'lookup_chain' array
    domain = records[records.keys.last][domain]
    resolve(records, lookup_chain << domain, domain)
  else
    # print error message when the domain name does not exist in any available records
    puts "Error: record not found for " + domain
    exit
  end
end

def parse_dns(file)
  records = {}; source = {}
  file.each do |line|
    splittedLine = line.strip.split(", ")

    # create a new hash when the value does not exist in the 'records' hash
    source = {} if not records.keys.include? splittedLine.first

    # store destination into 'source' hash
    source[splittedLine[1]] = splittedLine.last
    # store 'source' hash into 'records' hash
    records[splittedLine.first] = source
  end
  records
end

# ..
# ..

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
