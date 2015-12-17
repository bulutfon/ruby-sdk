require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Did < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'dids'
      end

      def all( params = {} )
        prepare_request( 'get', @resource,params)
      end

      def get( id )
        prepare_request( 'get', "#{@resource}/#{id}")
      end

    end
  end
end
