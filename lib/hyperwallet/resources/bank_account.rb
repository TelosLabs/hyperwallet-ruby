module Hyperwallet
  module Resources
    class BankAccount < Hyperwallet::Resources::TransferMethod

      ENDPOINT        = 'users'

      attr_accessor :bank_account_id,
                    :bank_account_purpose,
                    :bank_name,
                    :branch_id

      class << self
        def method_endpoint
          'bank-accounts'
        end
      end

    end
    
  end
end