module Hyperwallet
  module Resources
    class VenmoAccount < Hyperwallet::Resources::TransferMethod

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
      end
    end
  end
end