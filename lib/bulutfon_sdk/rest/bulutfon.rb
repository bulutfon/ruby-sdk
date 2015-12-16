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

    end
  end
end
