require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class CallRecord < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'call-records'
      end

      def get( uuid )
        uri = prepare_uri("#{@resource}/#{uuid}")
        { download_path: uri.to_s }
      end

      def get_stream( uuid)
        uri = prepare_uri("#{@resource}/#{uuid}/stream")
        { download_path: uri.to_s }
      end

      def save( uuid, save_path)
        save_file( 'get', "#{@resource}/#{uuid}", save_path)
      end

    end
  end
end
