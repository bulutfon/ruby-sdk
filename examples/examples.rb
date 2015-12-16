require 'bulutfon_sdk'

token = 'your_token'

# Account Details
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
puts bulutfon.details

# Message titles
message_title = BulutfonSDK::REST::MessageTitle.new(token)
puts message_title.all

# Messages
message = BulutfonSDK::REST::Message.new(token)
puts message.all
puts message.all({page: 1, limit: 3 })
puts message.get(message_id)

params = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Test Message', receivers: '905xxxxxxxxx'}
puts message.create(params)
params_multiple = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Multiple Message', receivers: '905xxxxxxxxx,905xxxxxxxxx'}
puts message.create(params_multiple)

params = {title: 'CONFIRMED_MESSAGE_TITLE', content: 'Planned message example', receivers: '905xxxxxxxxx', is_future_sms: true, send_date: '16/12/2015 10:00'}
puts message.create(params)


