require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class OutgoingFax < BaseRequest

      include BulutfonSDK::Util

      def initialize(*args)
        super(*args)
        @resource = 'outgoing-faxes'
      end

      def all( params = {} )
        prepare_request( 'get', @resource, params)
      end

      def get( uuid )
        prepare_request( 'get', "#{@resource}/#{uuid}")
      end

      def create(params)
        prepare_atachment(params)
        prepare_request( 'post', @resource, params)
      end

      private

      def prepare_atachment(params)
        file          = params[:attachment]
        basename      = File.basename file
        type          = file_content_type file
        content       = File.read(file)
        base_64_data  = Base64.strict_encode64(content)
        params[:attachment] = "data:#{type};name:#{basename};base64:#{base_64_data}"
      end

    end
  end
end
