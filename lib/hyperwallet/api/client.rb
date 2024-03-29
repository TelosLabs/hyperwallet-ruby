require 'faraday'

class Hyperwallet::Api::Client < Hyperwallet::Api::Config

  attr_accessor :client_id, :conn, :response, :body, :errors, :previous_payload

  def initialize
    # @client_id = client_id
    @conn      = get_connector
    add_headers
  end

  def get(resource:)
    self.response = conn.get do |request|
      request.url resource
    end
    handle_response
  end

  def post(resource:, payload: nil)
    @previous_payload = payload
    self.response = conn.post do |request|
      request.url resource
      request.body = payload
    end
    handle_response
  end

  private

  def handle_response
    if self.response.success? 
      @body = JSON.parse(self.response.body) unless self.response.body.empty?
    else
      @errors = JSON.parse(self.response.body)
    end
  end

  def get_connector
    Faraday.new(url: base_url, proxy: self.class.superclass.proxy) do |conn|
      conn.adapter :net_http
      conn.basic_auth(self.class.superclass.api_user, self.class.superclass.api_password) 
    end
  end

  def request_url_for(resource)
    base_url + "/" + resource
  end

  def base_url 
    active_url + API_VERSION
  end

  def active_url
    if self.class.superclass.uat?
      UAT_URL
    elsif self.class.superclass.production?
      PRODUCTION_URL
    end
  end

  def add_headers
    conn.headers.merge!(
      {
        'Content-Type'=> "application/json"
      }
    )
  end
end