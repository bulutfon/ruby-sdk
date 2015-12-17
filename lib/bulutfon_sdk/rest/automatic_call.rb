require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class AutomaticCall < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'automatic-calls'
      end

      def all( params = {} )
        prepare_request( 'get', @resource, params)
      end

      def get( id )
        prepare_request( 'get', "#{@resource}/#{id}")
      end

      def create(params)
        prepare_request( 'post', @resource, params)
      end

    end
  end
end
