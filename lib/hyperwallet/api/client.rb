require 'faraday'

class Hyperwallet::Api::Client < Hyperwallet::Api::Config

  attr_accessor :client_id, :conn, :response, :errors

  def initialize(client_id:)
    @client_id = client_id
    @conn      = Faraday.new(url: base_url) { |conn| conn.basic_auth(api_user, api_password) }
    add_headers
  end

  def get(resource:)

  end

  def post(resource:)

  end

  private

  def request_url_for(resource)
    base_url + "/" + resource
  end

  def base_url 
    API_URL + API_VERSION
  end

  def active_url
    if uat?
      UAT_URL
    elsif production?
      BASE_URL
    end
  end

  def add_headers
    conn.headers.merge!(
      {
        'Authorization'=> client_id,
        'Content-Type'=> "application/json"
      }
    )
  end
end