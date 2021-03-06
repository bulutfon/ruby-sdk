require 'bulutfon_sdk'

token = 'your_token'

# Account
# -------------------------------------------------------------
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
# BulutfonSDK::REST::CallRecord object
puts bulutfon.call_records
# BulutfonSDK::REST::IncomingFax object
puts bulutfon.incoming_faxes
# BulutfonSDK::REST::OutgoingFax object
puts bulutfon.outgoing_faxes
# BulutfonSDK::REST::Announcement object
puts bulutfon.announcements
# BulutfonSDK::REST::AutomaticCall object
puts bulutfon.automatic_calls

# Dids
# -------------------------------------------------------------
did = BulutfonSDK::REST::Did.new(token)
# Get dids
puts did.all
# Get did with id
puts did.get(1)

# Extensions
# -------------------------------------------------------------
extension = BulutfonSDK::REST::Extension.new(token)
# Get extensions
puts extension.all
# Get extension with id
puts extension.get(1)
# Create extension
params = {
    full_name: 'Deneme',
    email: 'deneme@deneme.com',
    did: '905xxxxxxxxx',
    number: 9999,
    redirection_type: 'NONE',
    destination_type: 'EXTENSION',
    destination_number: '905xxxxxxxxx',
    'acl[]' => [ 'domestic', 'gsm', 'international']
}
puts extension.create(params)
# Update extension
params = {
    full_name: 'Deneme Deneme',
    'acl[]' => [ 'domestic', 'gsm']
}
puts extension.update(1, params)
# Delete extension
puts extension.delete(1)

# Groups
# -------------------------------------------------------------
group = BulutfonSDK::REST::Group.new(token)
# Get groups
puts group.all
# Get group with id
puts group.get(1)

# Cdrs
# -------------------------------------------------------------
cdr = BulutfonSDK::REST::Cdr.new(token)
# Get cdrs
puts cdr.all
# Get cdrs with pagination
puts cdr.all({page: 1, limit: 1})
# Get cdr with uuid
puts cdr.get('uuid')

# Call Records
# -------------------------------------------------------------
call_record = BulutfonSDK::REST::CallRecord.new(token)
# Get call_record detail with uuid
puts call_record.get('uuid')
# Save call record to save_path with uuid
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_uuid.ogg"
puts call_record.save('uuid', save_path)

# Incoming Faxes
# -------------------------------------------------------------
incoming_fax = BulutfonSDK::REST::IncomingFax.new(token)
# Get incoming faxes
puts incoming_fax.all
# Get incoming fax with uuid
puts incoming_fax.get('uuid')
# Save incoming fax to save_path with uuid
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_uuid.tiff"
puts incoming_fax.save('uuid', save_path)

# Outgoing Faxes
# -------------------------------------------------------------
outgoing_fax = BulutfonSDK::REST::OutgoingFax.new(token)
# Get outgoing faxes
puts outgoing_fax.all
# Get outgoing fax with id
puts outgoing_fax.get(1)
# Create outgoing faxes
file = "#{File.expand_path(File.dirname(__FILE__))}/pdf-sample.pdf"
params = {
    title: 'Deneme',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx',
    attachment: file
}
puts outgoing_fax.create(params)

# Announcements
# -------------------------------------------------------------
announcement = BulutfonSDK::REST::Announcement.new(token)
# Get announcements
puts announcement.all
# Get announcement with id
puts announcement.get(1)
# Create announcement
file = "#{File.expand_path(File.dirname(__FILE__))}/test.wav"
params = {
    name: 'Deneme',
    announcement: file
}
puts announcement.create(params)
# Save announcement file to save_path with id
save_path = "#{File.expand_path(File.dirname(__FILE__))}/save_test.wav"
puts announcement.save(1, save_path)
# Delete announcement with id
puts announcement.delete(1)

# Automatic Calls
# -------------------------------------------------------------
automatic_call = BulutfonSDK::REST::AutomaticCall.new(token)
# Get automatic calls
puts automatic_call.all
# Get automatic call with id
puts automatic_call.get(1)
# Create automatic call, after creation receivers will call
params = {
    title: 'Automatic call after creation',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx',
    announcement_id: 1
}
puts automatic_call.create(params)
# Create time planned automatic call, in this params receivers will be calling on thursday between 10:15, 12:00
params = {
    title: 'Time planned call',
    receivers: '905xxxxxxxxx',
    did: '905xxxxxxxxx',
    announcement_id: 1,
    mon_active: false,
    tue_active: false,
    wed_active: false,
    thu_active: true,
    thu_start: '10:15',
    thu_finish: '12:00',
    fri_active: false,
    sat_active: false,
    sun_active: false,
    hours_active: true
}
puts automatic_call.create(params)

# Message Titles
# -------------------------------------------------------------
message_title = BulutfonSDK::REST::MessageTitle.new(token)
# Get message titles
puts message_title.all

# Messages
# -------------------------------------------------------------
message = BulutfonSDK::REST::Message.new(token)
# Get messages
puts message.all
# Get messages with pagination
puts message.all({page: 1, limit: 3 })
# Get message with id
puts message.get(1)
# Create message
params = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Test Message',
    receivers: '905xxxxxxxxx'
}
puts message.create(params)
# Create message for multiple receiver
params_multiple = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Multiple Message',
    receivers: '905xxxxxxxxx,905xxxxxxxxx'
}
puts message.create(params_multiple)
# Create time planned message
params = {
    title: 'CONFIRMED_MESSAGE_TITLE',
    content: 'Planned message example',
    receivers: '905xxxxxxxxx',
    is_future_sms: true,
    send_date: '16/12/2015 10:00'
}
puts message.create(params)

##############################################
# Create OpenStruct object from hash
##############################################

# Account
# -------------------------------------------------------------
bulutfon = BulutfonSDK::REST::Bulutfon.new(token)
# Get account details
puts bulutfon.details

# Details result is like below
=begin
details = {
    'user' =>{
        'email' => 'test@bulutfon.com', 'name' => 'BULUTFON', 'gsm' => 'XXXXXXXXXXXX'
    },
    'pbx' =>{
        'name' => 'test', 'url' => 'test.com', 'state' => 'CONFIRMED', 'package' => 'ENTERPRISE', 'customer_type' => 'CORPORATE'
    },
    'credit' =>{
        'balance' => '10.00', 'sms_credit' => 0
    }
}
=end

# to_obj is our helper method for hashes
detail_object = bulutfon.details.to_obj
puts detail_object

# Object Example
=begin
#<OpenStruct
  user=#<OpenStruct email="test@bulutfon.com", name="BULUTFON", gsm="XXXXXXXXXXXX">,
  pbx=#<OpenStruct name="test", url="test.com", state="CONFIRMED", package="ENTERPRISE", customer_type="CORPORATE">,
  credit=#<OpenStruct balance="10.00", sms_credit=0>>
=end

# You can access fields
puts detail_object.user.email
puts detail_object.user.name
puts detail_object.pbx.name
puts detail_object.pbx.url
puts detail_object.credit.balance
puts detail_object.credit.sms_credit

# Groups
# -------------------------------------------------------------
group_sdk   = BulutfonSDK::REST::Group.new(token)
obj_result  = group_sdk.all.to_obj
=begin
#<OpenStruct
  groups=[
    #<OpenStruct id=1, number=11, name="Ofis - İstanbul", timeout=30>,
    #<OpenStruct id=2, number=22, name="Ofis - Denizli", timeout=30>,
    #<OpenStruct id=3, number=33, name="İngilizce", timeout=30>
  ]>
=end
obj_result.groups.each do |group|
  puts group.name
end