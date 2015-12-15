module BulutfonSdk
  module Util
    class ClientConfig
      DEFAULTS = {
          host: 'https://api.bulutfon.com',
          port: 80,
          use_ssl: true,
          ssl_verify_peer: false,
          ssl_ca_file: File.dirname(__FILE__) + '/../../../conf/cacert.pem',
          timeout: 30,
          proxy_addr: nil,
          proxy_port: nil,
          proxy_user: nil,
          proxy_pass: nil,
          retry_limit: 2
      }

      DEFAULTS.each_key do |attribute|
        attr_accessor attribute
      end

      def initialize(opts={})
        DEFAULTS.each do |attribute, value|
          send("#{attribute}=".to_sym, opts.fetch(attribute, value))
        end
      end
    end
  end
end
