require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class MessageTitle < BaseRequest

        def initialize(*args)
          super(*args)
          @resource = 'message-titles'
        end

        def all( params = {} )
          prepare_request( 'get', @resource,params)
        end

    end
  end
end
