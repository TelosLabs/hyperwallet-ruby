$:.unshift File.dirname(__FILE__)

require "hyperwallet/version"

module Hyperwallet
  class Error < StandardError; end
  # Your code goes here...

  module Api

    class Config
      API_URL     = "https://api.sandbox.hyperwallet.com/rest"
      API_VERSION = "/v3"

      attr_reader :api_user, :api_password

      def set_api_user(user)
        @api_user = user
      end

      def set_api_password(password)
        @api_password = password
      end
    end

  end
end
