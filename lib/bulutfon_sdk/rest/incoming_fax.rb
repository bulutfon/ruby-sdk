require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class IncomingFax < BaseRequest

        def initialize(*args)
          super(*args)
          @resource = 'incoming-faxes'
        end

        def all( params = {} )
          prepare_request( 'get', @resource, params)
        end

        def get( uuid )
          uri = prepare_uri("#{@resource}/#{uuid}")
          { download_path: uri.to_s }
        end

    end
  end
end
