module Hyperwallet
  module Resources
    class BankAccount < Hyperwallet::Resources::TransferMethod

      ENDPOINT        = 'users'


      private 

      def validate_fields
        # validate_date -> must be a valid date in YYYY-MM-DD format
        # vaidate_program_token -> You must provide a valid program token (for a program which you have rights to
      end

      class << self
        def method_endpoint
          'bank-accounts'
        end

        def prepare_bank_account_create_payload(attributes)
          {
            profileType:                  attributes[:profile_type],
            transferMethodCountry:        attributes[:transfer_method_country],
            transferMethodCurrency:       attributes[:transfer_method_currency],
            type:                         attributes[:type],
            branchId:                     attributes[:branch_id],
            bankAccountId:                attributes[:bank_account_id],
            bankAccountPurpose:           attributes[:bank_account_purpose],
            firstName:                    attributes[:first_name],
            lastName:                     attributes[:last_name],
            country:                      attributes[:country],
            stateProvince:                attributes[:state_province],
            addressLine1:                 attributes[:address_line_1],
            city:                         attributes[:city],
            postalCode:                   attributes[:postal_code],
            bankAccountRelationship:      attributes[:bank_account_relationship]
          }
        end

      end
    end
  end
end