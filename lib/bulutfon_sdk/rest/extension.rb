require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Extension < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'extensions'
      end

      def all( params = {} )
        prepare_request( 'get', @resource,params)
      end

      def get( id )
        prepare_request( 'get', "#{@resource}/#{id}")
      end

      def create(params)
        prepare_request( 'post', @resource, params)
      end

      def update(id, params)
        prepare_request( 'put', "#{@resource}/#{id}", params)
      end

      def delete(id)
        prepare_request( 'delete', "#{@resource}/#{id}")
      end
    end
  end
end
