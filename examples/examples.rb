require 'bulutfon_sdk'

token = 'your_token'

bulutfon = BulutfonSdk::REST::Bulutfon.new(token)
# Account Details
puts bulutfon.details

message = BulutfonSdk::REST::Message.new(token)

# Message titles
puts message.titles

# Messages
# puts message.get_message(message_id)

params = {'title' => 'TEST', 'content' => 'TEST Message', 'receivers' => '90xxxxxxxxxx'}
puts message.create(params)