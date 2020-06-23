module Hyperwallet
  module Api
    class Config

      PRODUCTION_URL     = "https://api.sandbox.hyperwallet.com/rest"
      UAT_URL            = "https://uat-api.paylution.com/rest"

      API_VERSION = "/v3"
      MODES       = [:uat, :production]

      class << self
        cattr_accessor :api_user, :api_password, :api_mode

        def uat?
          api_mode == :uat
        end

        def production?
          api_mode == :production
        end
      end
    end
  end
end