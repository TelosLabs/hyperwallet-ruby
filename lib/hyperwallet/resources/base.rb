module Hyperwallet
  module Resources
    class Base

      class << self
        cattr_accessor :connector

        def connector
          @connector ||= Hyperwallet::Api::Client.new
        end
      end

    end
  end
end