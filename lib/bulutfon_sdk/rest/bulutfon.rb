require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Bulutfon < BaseRequest

      def initialize(*args)
        super(*args)
      end

      def details
        prepare_request( 'get', 'me')
      end

      def messages
        BulutfonSDK::REST::Message.new(@token)
      end

      def message_titles
        BulutfonSDK::REST::MessageTitle.new(@token)
      end

      def extensions
        BulutfonSDK::REST::Extension.new(@token)
      end

      def dids
        BulutfonSDK::REST::Did.new(@token)
      end

      def groups
        BulutfonSDK::REST::Group.new(@token)
      end

      def cdrs
        BulutfonSDK::REST::Cdr.new(@token)
      end

      def incoming_faxes
        BulutfonSDK::REST::IncomingFax.new(@token)
      end

      def outgoing_faxes
        BulutfonSDK::REST::OutgoingFax.new(@token)
      end

      def announcements
        BulutfonSDK::REST::Announcement.new(@token)
      end

      def automatic_calls
        BulutfonSDK::REST::AutomaticCall.new(@token)
      end
    end
  end
end
