require 'bulutfon_sdk/rest/base_request'

module BulutfonSdk
  module REST
    class Message < BaseRequest

        def initialize(*args)
          super(*args)
        end

        def titles( params = {} )
          prepare_request( 'get', 'message-titles',params)
        end

        def messages( params = {} )
          prepare_request( 'get', 'messages',params)
        end

        def get_message( id )
          prepare_request( 'get', "messages/#{id}")
        end

        def create(params)
          prepare_request( 'post', 'messages', params)
        end

    end
  end
end
