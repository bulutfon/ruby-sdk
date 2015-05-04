require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bulutfon < OmniAuth::Strategies::OAuth2
      option :client_options, {
                                site: 'https://api.bulutfon.com',
                                authorize_url: 'https://www.bulutfon.com/oauth/authorize',
                                token_url: 'https://www.bulutfon.com/oauth/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'email' => raw_info['user']['email'],
          'name' => raw_info['user']['name'],
          'gsm' => raw_info['user']['gsm'],

          'pbx' => {
            'name' => raw_info['pbx']['name'],
            'url' => raw_info['pbx']['url'],
            'state' => raw_info['pbx']['state'],
            'package' => raw_info['pbx']['package'],
            'customer_type' => raw_info['pbx']['customer_type'],
          },
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('me').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'bulutfon', 'Bulutfon'
