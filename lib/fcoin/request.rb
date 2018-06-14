require 'base64'
require 'openssl'
require 'faraday'
require 'json'

module Fcoin
  module Request
    BaseURL = "https://api.fcoin.com/v2/"

    def configuration(key, secret)
      @key = key
      @secret = secret
    end

    def get(path, options={})
      request(:get, path, options)
    end

    def post(path, options={})
      request(:post, path, options)
    end

  private

    def request(method, path, options)
      ts = (Time.now.to_f*1000).to_i
      response = connection.send(method) do |request|
        request.headers['FC-ACCESS-SIGNATURE'] = sign(method, path, ts, options)
        request.headers['FC-ACCESS-TIMESTAMP'] = ts.to_s
        request.headers['Content-Type'] = 'application/json;charset=UTF-8'
        case method
        when :get
          request.url(path, options)
        when :post
          request.path = path
          request.body = options.to_json
        end
      end
      JSON.load response.body
    end

    def connection
      Faraday.new(
        headers: { 'FC-ACCESS-KEY' => @key },
        url: BaseURL,
        request: { open_timeout: 10, timeout: 5 }
      ) do |connection|
        connection.adapter(Faraday.default_adapter)
      end
    end

    def sign(method, path, ts, options)
      merge_options = options.sort.map{|arr| "#{arr[0]}=#{arr[1]}"}.join('&')
      if method == :get && merge_options != ""
        str = "#{method.upcase}#{BaseURL}#{path}?#{merge_options}#{ts}"
      else
        str = "#{method.upcase}#{BaseURL}#{path}#{ts}#{merge_options}"
      end
      Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', @secret, Base64.strict_encode64(str)))
    end
  end
end
