require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Cdr < BaseRequest

        def initialize(*args)
          super(*args)
          @resource = 'cdrs'
        end

        def all( params = {} )
          prepare_request( 'get', @resource,params)
        end

        def get( uuid )
          prepare_request( 'get', "#{@resource}/#{uuid}")
        end

    end
  end
end
