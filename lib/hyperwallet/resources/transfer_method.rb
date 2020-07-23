module Hyperwallet
  module Resources
    class TransferMethod < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      attr_accessor :address_line1,
                    :city,
                    :country,
                    :created_on,
                    :date_of_birth,
                    :first_name,
                    :last_name,
                    :links,
                    :postal_code,
                    :profile_type,
                    :state_province,
                    :status,
                    :token,
                    :transfer_method_country,
                    :transfer_method_currency,
                    :type,
                    :user_token,
                    :verification_status

      class << self
        def index(user_token:)
          connector.get(resource: resource_endpoint(token: user_token))
          handle_response
        end

        def create(user_token:, payload:)
          response = connector.post(resource: resource_endpoint(token: user_token), 
                                    payload:  prepare_payload(payload_attributes: payload).to_json)
          instantiate_from_data(response)
        end

        def resource_endpoint(token:)
          ENDPOINT + "/" + token + "/" + method_endpoint
        end

        def method_endpoint
          'transfer-methods'
        end
      end
    end
  end
end
