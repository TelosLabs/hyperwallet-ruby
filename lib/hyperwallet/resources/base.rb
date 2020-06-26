module Hyperwallet
  module Resources
    class Base

      attr_accessor :connector

      def connector
        @connector ||= Hyperwallet::Api::Client.new
      end

      class << self
        cattr_accessor :connector

        def connector
          @connector ||= Hyperwallet::Api::Client.new
        end
      end

    end
  end
end