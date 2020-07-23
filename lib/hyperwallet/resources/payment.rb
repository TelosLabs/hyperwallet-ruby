module Hyperwallet
  module Resources
    class Payment < Hyperwallet::Resources::Base
      ENDPOINT = 'payments'

      attr_accessor  :amount,
                     :client_payment_id,
                     :created_on,
                     :currency,
                     :destination_token,
                     :expires_on,
                     :links,
                     :program_token,
                     :purpose,
                     :status,
                     :token

      def show(token:)
        connector.get(resource: ENDPOINT + "/" + token)
        handle_response
      end

      class << self
        def index
          connector.get(resource: ENDPOINT)
          #TODO: instantiate payments, add_pagination, etc.
        end

        def create(payload:)
          response = connector.post(resource: ENDPOINT, 
                                    payload: prepare_payload(payload_attributes: payload).to_json)
          instantiate_from_data(response)
        end
      end

    end
  end
end

