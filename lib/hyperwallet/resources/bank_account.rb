module Hyperwallet
  module Resources
    class BankAccount < Hyperwallet::Resources::TransferMethod

      ENDPOINT        = 'users'

      class << self
        def method_endpoint
          'bank-accounts'
        end
      end

    end
    
  end
end