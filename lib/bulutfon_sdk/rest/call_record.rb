require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class CallRecord < BaseRequest

      def initialize(*args)
        super(*args)
        @resource = 'call-records'
      end

      def get( uuid, encrypt_token = false )
        uri = prepare_uri("#{@resource}/#{uuid}", {encrypt_token: encrypt_token, id: uuid})
        { download_path: uri.to_s }
      end

      def get_stream( uuid, encrypt_token = false )
        uri = prepare_uri("#{@resource}/#{uuid}/stream", {encrypt_token: encrypt_token, id: uuid})
        { download_path: uri.to_s }
      end

      def save( uuid, save_path, encrypt_token = false)
        save_file( 'get', "#{@resource}/#{uuid}", save_path, {encrypt_token: encrypt_token, id: uuid})
      end

    end
  end
end
