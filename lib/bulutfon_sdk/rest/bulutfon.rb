require 'bulutfon_sdk/rest/base_request'

module BulutfonSdk
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
