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
      end

      def show(token:)
      end

      def update(token:)
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