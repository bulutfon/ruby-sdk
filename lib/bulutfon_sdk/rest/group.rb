require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Group < BaseRequest

        def initialize(*args)
          super(*args)
          @resource = 'groups'
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
