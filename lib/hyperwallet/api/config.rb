module Hyperwallet
  module Api
    class Config

      PRODUCTION_URL         = "https://api.paylution.com/rest"
      UAT_URL                = "https://uat-api.paylution.com/rest"
      PRODUCTION_API_VERSION = "/v3"
      UAT_API_VERSION        = "/v4"
      MODES                  = [:uat, :production]

      class << self
        attr_accessor :api_user, :api_password, :api_mode, :proxy
        def uat?
          api_mode == :uat
        end

        def production?
          api_mode == :production
        end

        def api_version
          return PRODUCTION_API_VERSION if production?

          UAT_API_VERSION
        end
      end
    end
  end
end
