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

def resolve(dns_records, lookup_chain, domain)
  record = dns_records[domain]
  if (!record)
    # display error message when the domain name is not exist in `record`
    lookup_chain.clear << "Error: Record not found for " + domain
  elsif record[:type] == "CNAME"
    # push `record[:targe]` to `lookup_chain`
    resolve(dns_records, lookup_chain << record[:target], record[:target])
  elsif record[:type] == "A"
    # push `record[:targe]` to `lookup_chain`
    # and return `look_up`
    lookup_chain << record[:target]
  else
    lookup_chain.clear << "Invalid record type for " + domain
  end
end

def parse_dns(raw)
  raw.
    reject { |line| line.empty? }.
    map { |line| line.strip.split(", ") }.
    # reject the line which doesn't have the first value is `A` or `CNAME`
    reject { |record| record[0] != "A" and record[0] != "CNAME" }.
    each_with_object({}) do |record, records|
    # records[record source] = { type: record type, target: source destination }
    records[record[1]] = { type: record[0], target: record[2] }
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
