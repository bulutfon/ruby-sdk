require 'bulutfon_sdk'

token = 'your_token'

# Account Details
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
# Get account details
puts bulutfon.details

# Dids
did = BulutfonSDK::REST::Did.new(token)
# Get dids
puts did.all
# Get dids with pagination
puts did.all({page: 1, limit: 1})
# Get did with id
puts did.get(1)

# Message titles
message_title = BulutfonSDK::REST::MessageTitle.new(token)
# Get message titles
puts message_title.all

# Messages
message = BulutfonSDK::REST::Message.new(token)
# Get messages
puts message.all
# Get messages with pagination
puts message.all({page: 1, limit: 3 })
# Get message with id
puts message.get(1)

# Create message
params = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Test Message', receivers: '905xxxxxxxxx'}
puts message.create(params)
# Create message for multiple receiver
params_multiple = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Multiple Message', receivers: '905xxxxxxxxx,905xxxxxxxxx'}
puts message.create(params_multiple)
# Create planned message
params = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Planned message example', receivers: '905xxxxxxxxx', is_future_sms: true, send_date: '16/12/2015 10:00'}
puts message.create(params)


