require 'active_support/json'

module Hyperwallet
  module Resources
    class Payee < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      attr_accessor :attributes

      def initialize(**args)
        @attributes = args
        validate_fields
      end

      def create
        connector.post(resource: ENDPOINT, payload: prepare_create_payload.to_json)
        handle_response
      end

      def show(token:)
        connector.get(resource: ENDPOINT + "/" + token)
      end

      # def update(token:)
      # end

      def index_bank_accounts
        connector.get(resource: bank_account.resource_endpoint(token: attributes[:token]))
      end

      def create_bank_account
        connector.post(resource: bank_account.resource_endpoint(token: attributes[:token]), 
                       payload:  bank_account.prepare_bank_account_create_payload(attributes).to_json)
        handle_response
      end

      def get_authentication_token
        connector.post(resource: ENDPOINT+"/"+ attributes[:token] +"/authentication-token")
        handle_response("value")
      end

      def success?
        connector.response.success?
      end

      private 

      def handle_response(key: nil)
        return connector.errors unless success?
        if key
          connector.body[key]
        else
          connector.body
        end
      end

      def prepare_create_payload
        {
          clientUserId:     attributes[:client_user_id],
          profileType:      attributes[:profile_type],
          firstName:        attributes[:first_name],
          lastName:         attributes[:last_name],
          dateOfBirth:      attributes[:date_of_birth],
          email:            attributes[:email],
          addressLine1:     attributes[:address_line_1],
          city:             attributes[:city],
          stateProvince:    attributes[:state_province],
          country:          attributes[:country],
          postalCode:       attributes[:postal_code],
          programToken:     attributes[:program_token]
        }
      end

      def validate_fields
        # validate_date -> must be a valid date in YYYY-MM-DD format
        # vaidate_program_token -> You must provide a valid program token (for a program which you have rights to
      end

      def bank_account
        Hyperwallet::Resources::BankAccount
      end

      class << self
        def index
          connector.get(resource: ENDPOINT)
        end
      end
    end
  end
end