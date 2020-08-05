require 'active_support/json'

module Hyperwallet
  module Resources
    class Receipt < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      attr_accessor :token,
                    :journal_id,
                    :type,
                    :created_on,
                    :entry,
                    :source_token,
                    :destination_token,
                    :amount,
                    :fee,
                    :currency,
                    :details


      def show(token: nil)
        token ||= @token
        connector.get(resource: ENDPOINT + "/" + token + "/" + method_endpoint)
        handle_response
      end

      private 

      def method_endpoint
        'receipts'
      end
    end
  end
end