module Hyperwallet
  module Resources
    class VenmoAccount < Hyperwallet::Resources::TransferMethod

      ENDPOINT        = 'bank-accounts'

      class << self
        def method_endpoint
          ENDPOINT
        end
      end

    end
    
  end
end