require 'bulutfon-sdk/version'
require 'omniauth/strategies/bulutfon'

class Bulutfon
  def initialize(access_token, refresh_token)
    @access_token = access_token
    @refresh_token = refresh_token
  end

  %w(dids extensions groups cdrs).each do |end_point|
    send :define_method, end_point do |data={}|
      access(end_point, data)
    end
  end

  def access(end_point, data={})
    conn = Faraday.new(:url => 'https://api.bulutfon.com', :ssl => {:verify => false}) do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    data = data.merge(access_token: @access_token)

    response = conn.get "/#{end_point}", data
    JSON.parse(response.body)
  end

  def refresh_token(client_id, client_secret, access_token, refresh_token, callback_url)
    conn = Faraday.new(:url => 'https://bulutfon.com', :ssl => {:verify => false}) do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.post '/oauth/token', {client_id: client_id, client_secret: client_secret, access_token: access_token, refresh_token: refresh_token, grant_type: 'refresh_token', callback_url: callback_url}
    response.body
  end
end