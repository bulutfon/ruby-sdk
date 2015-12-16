require 'bulutfon_sdk'

token = 'your_token'

# Account
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
# Get account details
puts bulutfon.details
# BulutfonSDK::REST::Message object
puts bulutfon.messages
# BulutfonSDK::REST::MessageTitle object
puts bulutfon.message_titles
# BulutfonSDK::REST::Did object
puts bulutfon.dids
# BulutfonSDK::REST::Extension object
puts bulutfon.extensions
# BulutfonSDK::REST::Group object
puts bulutfon.groups
# BulutfonSDK::REST::Cdr object
puts bulutfon.cdrs

# Dids
did = BulutfonSDK::REST::Did.new(token)
# Get dids
puts did.all
# Get did with id
puts did.get(1)

# Extensions
extension = BulutfonSDK::REST::Extension.new(token)
# Get extensions
puts extension.all
# Get extension with id
puts extension.get(1)
# Create extension
params = {full_name: 'Deneme', email: 'deneme@deneme.com', did: '905xxxxxxxxx', number: 9999, redirection_type: 'NONE', destination_type: 'EXTENSION',  destination_number: '905061189668', 'acl[]' => ['domestic', 'gsm', 'international'] }
puts extension.create(params)
# Update extension
params = {full_name: 'Deneme Deneme', 'acl[]' => ['domestic', 'gsm']  }
puts extension.update(1, params)
# Delete extension
puts extension.delete(1)

# Groups
group = BulutfonSDK::REST::Group.new(token)
# Get groups
puts group.all
# Get group with id
puts group.get(1)

# Cdrs
cdr = BulutfonSDK::REST::Cdr.new(token)
# Get cdrs
puts cdr.all
# Get cdrs with pagination
puts cdr.all({page: 1, limit: 1})
# Get cdr with uuid
puts cdr.get('uuid')

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

