require 'active_support/json'

module Hyperwallet
  module Resources
    class Payee < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      attr_accessor :token,
                    :status,
                    :verification_status,
                    :created_on,
                    :client_user_id,
                    :profile_type,
                    :first_name,
                    :last_name,
                    :date_of_birth,
                    :email,
                    :address_line1,
                    :city,
                    :state_province,
                    :country,
                    :postal_code,
                    :program_token

      def show(token: nil)
        token ||= @token
        connector.get(resource: ENDPOINT + "/" + token)
        handle_response
        process_fields(connector.body)
      end

      def update(token:, attributes_to_update: )
        connector.put(resource: ENDPOINT + "/" + token, payload: prepare_payload(payload_attributes: attributes_to_update).to_json)
        handle_response
        process_fields(connector.body)
      end

      def index_bank_accounts
        connector.get(resource: bank_account.resource_endpoint(token: attributes[:token]))
        handle_response
      end

      def create_bank_account
        connector.post(resource: bank_account.resource_endpoint(token: attributes[:token]), 
                       payload:  bank_account.prepare_bank_account_create_payload(attributes).to_json)
        handle_response
      end

      def get_authentication_token(user_token: nil)
        user_token ||= token
        connector.post(resource: ENDPOINT+"/"+ user_token +"/authentication-token")
        handle_response(key: "value")
      end

      private 

      def bank_account
        Hyperwallet::Resources::BankAccount
      end

      class << self
        def index
          connector.get(resource: ENDPOINT)
        end

        def create(create_attributes:)
          response = connector.post(resource: ENDPOINT, payload: prepare_payload(payload_attributes: create_attributes).to_json)
          instantiate_from_data(response)
        end
      end
    end
  end
end