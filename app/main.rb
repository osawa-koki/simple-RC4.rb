require 'optparse'
require_relative 'RC4'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-k KEY", "--key KEY", String, "Encryption key") do |key|
    options[:key] = key
  end

  opts.on("-m MESSAGE", "--message MESSAGE", String, "Message to encrypt") do |message|
    options[:message] = message
  end

end.parse!

if options[:key].nil? || options[:message].nil?
  puts "Error: --key and --message options are required."
  exit 1
end

key = options[:key]
message = options[:message]

puts "key: #{key}"
puts "message: #{message}"

encrypt_result = encrypt(message, key)
decrypt_result = decrypt(encrypt_result, key)

puts "encrypt: #{encrypt_result}"
puts "decrypt: #{decrypt_result}"
