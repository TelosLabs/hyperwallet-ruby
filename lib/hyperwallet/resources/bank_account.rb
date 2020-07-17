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
          'venmo-accounts'
        end

        # def prepare_venmo_account_create_payload(attributes)
        # end
      end
    end
  end
end