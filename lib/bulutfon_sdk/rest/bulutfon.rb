require 'bulutfon_sdk/rest/base_request'
require 'bulutfon_sdk/rest/did'
require 'bulutfon_sdk/rest/extension'
require 'bulutfon_sdk/rest/message'
require 'bulutfon_sdk/rest/message_title'

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
    end
  end
end
