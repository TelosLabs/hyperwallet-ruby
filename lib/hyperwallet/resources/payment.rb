module Hyperwallet
  module Resources
    class Payment < Hyperwallet::Resources::Base
      ENDPOINT = 'payments'

      attr_accessor :attributes, :body

      def initialize(**args)
        @attributes = args
        validate_fields
      end

      def create
        connector.post(resource: ENDPOINT, payload: prepare_create_payload.to_json)
        handle_response
      end

      def show(token:)
      end

      def update(token:)
      end

      private

      def validate_fields
        # validate elements
      end

      def prepare_create_payload
        {
          amount:           attributes[:amount],
          clientPaymentId:  attributes[:client_payment_id],
          currency:         "USD",
          destinationToken: attributes[:destination_token],
          programToken:     attributes[:program_token],
          purpose:          attributes[:purpose]
        }
      end

      def handle_response(key: nil)
        return connector.errors unless success?
        @body = if key
          connector.body[key]
        else
          connector.body
        end
      end

      def success?
        connector.response.success?
      end
    end
  end
end

