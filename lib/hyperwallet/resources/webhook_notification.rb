module Hyperwallet
  module Resources
    class WebhookNotification < Hyperwallet::Resources::Base
      ENDPOINT = 'webhook-notifications'


      def method_endpoint
        ENDPOINT
      end
      
      class << self
        def method_endpoint
          ENDPOINT
        end
      end

    end
  end
end

