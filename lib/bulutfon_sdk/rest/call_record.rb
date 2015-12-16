require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class CallRecord < BaseRequest

        def initialize(*args)
          super(*args)
          @resource = 'call-records'
        end

        def get( uuid )
          request_path          = "#{@config.host}/#{@resource}/#{uuid}"
          uri                   = URI.parse(request_path)
          params                = { access_token: @token }
          uri.query             = URI.encode_www_form(params)
          { download_path: uri.to_s }
        end

    end
  end
end
