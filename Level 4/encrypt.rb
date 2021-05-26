require "aes"

source_file = ARGV[0]
password = ARGV[1]
encrypted = AES.encrypt(File.read(source_file), password)

target_file = "#{source_file}.enc"
File.open(target_file, "wb") { |f| f.write(encrypted) }
system "rm " + source_file
puts "File encrypted to #{target_file} with password #{password}"
