require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Announcement < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'announcements'
      end

      def all( params = {} )
        prepare_request( 'get', @resource,params)
      end

      def get( id )
        uri = prepare_uri("#{@resource}/#{id}")
        { download_path: uri.to_s }
      end

    end
  end
end
