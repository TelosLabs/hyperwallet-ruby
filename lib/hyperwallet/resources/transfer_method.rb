module Hyperwallet
  module Resources
    class TransferMethod < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      def validate_fields
        # validate_date -> must be a valid date in YYYY-MM-DD format
        # vaidate_program_token -> You must provide a valid program token (for a program which you have rights to
      end

      class << self
        def index(user_token:)
          connector.get(resource: ENDPOINT + "/" + user_token + "/" + method_endpoint)
        end

        def resource_endpoint(token:)
          ENDPOINT + "/" + token + "/" + method_endpoint
        end
      end
    end
  end
end