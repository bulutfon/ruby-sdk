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
        BulutfonSDK::REST::Message.new(@token || @email, @password)
      end

      def message_titles
        BulutfonSDK::REST::MessageTitle.new(@token || @email, @password)
      end

      def extensions
        BulutfonSDK::REST::Extension.new(@token || @email, @password)
      end

      def dids
        BulutfonSDK::REST::Did.new(@token || @email, @password)
      end

      def groups
        BulutfonSDK::REST::Group.new(@token || @email, @password)
      end

      def cdrs
        BulutfonSDK::REST::Cdr.new(@token || @email, @password)
      end

      def call_records
        BulutfonSDK::REST::CallRecord.new(@token || @email, @password)
      end

      def incoming_faxes
        BulutfonSDK::REST::IncomingFax.new(@token || @email, @password)
      end

      def outgoing_faxes
        BulutfonSDK::REST::OutgoingFax.new(@token || @email, @password)
      end

      def announcements
        BulutfonSDK::REST::Announcement.new(@token || @email, @password)
      end

      def automatic_calls
        BulutfonSDK::REST::AutomaticCall.new(@token || @email, @password)
      end

    end
  end
end
