module Hyperwallet
  module Resources
    class Base

      attr_accessor :connector, :body, :errors, :target

      def initialize(**args)
        process_fields(args)
      end

      def connector
        @connector ||= Hyperwallet::Api::Client.new
      end

      def prepare_payload(payload_attributes:)
        # Should be moved to a module
        payload = {}
        payload_attributes.each_pair do |key, value|
          payload.merge!({camelCase(key).to_sym => value})
        end
        payload
      end

      def set_and_validate(key, value)
        # validate_date -> must be a valid date in YYYY-MM-DD format
        # vaidate_program_token -> You must provide a valid program token (for a program which you have rights to
        instance_variable_set("@#{key}".to_sym, value)
        validation = validation_name_for(key)
        send(validation, value) if self.respond_to? validation
      end

      def process_fields(fields = nil)
        attributes = fields if fields

        attributes&.each_pair do |key, value|
          set_and_validate(key, value)
        end
      end

      def validation_name_for(key)
        "validate_#{key}".to_sym
      end

      def camelCase(key)
        # Should be moved to a module
        components = key.to_s.split("_")
        first      = components[0].downcase
        others     = components[1..].map { |c| c.capitalize}
        [first, others].join
      end

      def snakecase(key)
        key.to_s.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr('-', '_').
        gsub(/\s/, '_').
        gsub(/__+/, '_').
        downcase
      end

      def handle_response(key: nil)
        @errors = connector.errors unless success?
        @target = connector.body[key.to_s] if key
      end

      def success?
        connector.response.success?
      end

      class << self
        cattr_accessor :connector

        def connector
          @connector ||= Hyperwallet::Api::Client.new
        end

        def success?
          connector.response.success?
        end

        def prepare_payload(payload_attributes:)
          # Should be moved to a module
          payload = {}
          payload_attributes.each_pair do |key, value|
            payload.merge!({camelCase(key).to_sym => value})
          end
          payload
        end

        def instantiate_from_data(data = {})
          return unless success?
          attributes = {}
          data.each_pair do |key, value|
            attributes.merge!({snakecase(key).to_sym => value})
          end
          self.send(:new, attributes)
        end

        def camelCase(key)
          # Should be moved to a module
          components = key.to_s.split("_")
          first      = components[0].downcase
          others     = components[1..].map { |c| c.capitalize}
          [first, others].join
        end

        def snakecase(key)
          key.to_s.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr('-', '_').
          gsub(/\s/, '_').
          gsub(/__+/, '_').
          downcase
        end
      end

    end
  end
end