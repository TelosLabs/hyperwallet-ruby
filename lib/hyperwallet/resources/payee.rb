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
        if success?
          connector.body
        else
          connector.errors
        end
      end

      def show(token:)
      end

      def update(token:)
      end

      def get_authentication_token
        connector.post(resource: ENDPOINT+"/"+ attributes[:token] +"/authentication-token")
        if success?
          connector.body["value"]
        else
          connector.errors
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

      def success?
        connector.response.success?
      end

      private 

      def validate_fields
        # validate_date -> must be a valid date in YYYY-MM-DD format
        # vaidate_program_token -> You must provide a valid program token (for a program which you have rights to
      end

      class << self
        def index
          connector.get(resource: ENDPOINT)
        end
      end
    end
  end
end