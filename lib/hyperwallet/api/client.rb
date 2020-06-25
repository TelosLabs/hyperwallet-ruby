require 'faraday'
require 'pry'

class Hyperwallet::Api::Client < Hyperwallet::Api::Config

  attr_accessor :client_id, :conn, :response, :errors

  def initialize
    # @client_id = client_id
    @conn      = get_connector
    add_headers
  end

  def get(resource:)
    self.response = conn.get do |request|
      request.url resource
    end
  end

  def post(resource:)

  end

  private

  def get_connector
    Faraday.new(url: base_url) do |conn| 
      conn.basic_auth(self.class.api_user, self.class.api_password) 
    end
  end

  def request_url_for(resource)
    base_url + "/" + resource
  end

  def base_url 
    active_url + API_VERSION
  end

  def active_url
    if self.class.uat?
      UAT_URL
    elsif self.class.production?
      BASE_URL
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