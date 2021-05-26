require "aes"

source_file = ARGV[0]
password = ARGV[1]
decrypted = AES.decrypt(File.read(source_file), password)

target_file = source_file.slice(0, source_file.size - 4)
File.open(target_file, "wb") { |f| f.write(decrypted) }
system "rm " + source_file
puts "File decrypted to #{target_file} with password #{password}"
