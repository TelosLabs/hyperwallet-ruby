module Hyperwallet
  module Resources
    class Payee < Hyperwallet::Resources::Base

      ENDPOINT = 'users'

      class << self
        def index
          connector.get(resource: ENDPOINT)
        end

        def create
        end

        def show(token:)
        end

        def update(token:)
        end
      end
    end
  end
end