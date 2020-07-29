module Hyperwallet
  module Resources
    class VenmoAccount < Hyperwallet::Resources::TransferMethod

      ENDPOINT        = 'users'

      class << self
        def method_endpoint
          "bank-accounts"
        end
      end

    end
    
  end
end