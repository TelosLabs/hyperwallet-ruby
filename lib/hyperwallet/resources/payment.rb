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

      def method_endpoint
        ENDPOINT
      end

      class << self

        def method_endpoint
          ENDPOINT
        end
      end

    end
  end
end

