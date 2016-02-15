module BulutfonSDK
  module REST
    class BaseRequest

      HTTP_HEADERS = {
          'Accept'          => 'application/json',
          'Accept-Charset'  => 'utf-8',
          'User-Agent'      => "bulutfon_sdk/#{BulutfonSDK::VERSION}" " (#{RUBY_ENGINE}/#{RUBY_PLATFORM}" " #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})"
      }

      def initialize(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        @config = BulutfonSDK::Util::ClientConfig.new options
        @token = args[0] || nil
        raise ArgumentError, 'Auth token is required' if @token.nil?
        set_up_connection
      end

      protected
        ##
        # Prepare URI object for file path
        def prepare_uri(path, params = {})
          uri       = uri_parse(params, path)
          uri.query = URI.encode_www_form(params)
          uri
        end

        ##
        # Prepare http request
        def prepare_request(method, path, params = {})
          uri                   = uri_parse(params, path)
          uri.query             = URI.encode_www_form(params) if ['get', 'delete'].include?(method)
          method_class          = Net::HTTP.const_get method.to_s.capitalize
          request               = method_class.new(uri.to_s, HTTP_HEADERS)
          request.form_data     = params if ['post', 'put'].include?(method)
          connect_and_send(request)
        end

        ##
        # URI parse for params
        def uri_parse(params, path)
          request_path = "#{@config.host}/#{path}"
          uri = URI.parse(request_path)
          params[:access_token] = @token
          uri
        end

        ##
        # Prepare http request for file saving
        def save_file(method, path, save_path)
          uri          = prepare_uri(path)
          method_class = Net::HTTP.const_get method.to_s.capitalize
          request      = method_class.new(uri.to_s, HTTP_HEADERS)
          response     = connect_and_send(request, is_file: true )
          begin
            file = File.open(save_path, 'w')
            file.write(response)
          rescue => error
            raise BulutfonSDK::REST::SDKError.new error
          ensure
            file.close unless file.nil?
          end
          { file: file, save_path: save_path }
        end

        ##
        # Set up and cache a Net::HTTP object to use when making requests.
        def set_up_connection # :doc:
          uri                = URI.parse(@config.host)
          @http              = Net::HTTP.new(uri.host, uri.port, p_user = @config.proxy_user, p_pass =  @config.proxy_pass)
          @http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
          @http.use_ssl      = @config.use_ssl
          if @config.ssl_verify_peer
            @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
            @http.ca_file     = @config.ssl_ca_file
          else
            @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
          @http.open_timeout = @config.timeout
          @http.read_timeout = @config.timeout
        end

        ##
        # Send an HTTP request using the cached <tt>@http</tt> object and
        # return the JSON response body parsed into a hash. Also save the raw
        # Net::HTTP::Request and Net::HTTP::Response objects as
        # <tt>@last_request</tt> and <tt>@last_response</tt> to allow for
        # inspection later.
        def connect_and_send(request, is_file = false ) # :doc:
          @last_request = request
          retries_left = @config.retry_limit
          begin
            response = @http.request request
            @last_response = response
            if response.kind_of? Net::HTTPServerError
              raise BulutfonSDK::REST::ServerError
            end
          rescue
            raise if request.class == Net::HTTP::Post
            if retries_left > 0 then retries_left -= 1; retry else raise end
          end
          if response.body and !response.body.empty?
            if is_file
              object = response.body
            else
              object = MultiJson.load response.body
            end
          elsif response.kind_of? Net::HTTPBadRequest
            object = { message: 'Bad request', code: 400 }
          end

          if response.kind_of? Net::HTTPClientError
            raise BulutfonSDK::REST::RequestError.new object['error'], object['code']
          end
          object
        end

    end
  end
end
