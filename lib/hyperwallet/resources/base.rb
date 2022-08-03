module Hyperwallet
  module Resources
    class Base

      attr_accessor :connector, :body, :errors, :target

      def initialize(**args)
        process_fields(args)
      end

      def show(token:)
        connector.get(resource: method_endpoint + "/" + token)
        handle_response
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
        @target = if key
          connector.body[key.to_s]
        else
          connector.body
        end
        process_fields(data_for_hydration)
      end

      def success?
        connector.response.success?
      end

      def failed?
        !success?
      end

      def data_for_hydration
        if success?
          connector.body
        else
          attributes = connector&.previous_payload || {}
          attributes.merge(connector.errors)
        end
      end

      class << self
        attr_accessor :connector

        def index
          connector.get(resource: method_endpoint)
        end

        def create(data)
          response = connector.post(resource: method_endpoint, 
                                    payload: JSON.generate(prepare_payload(payload_attributes: data)))
          
          data = if success?
            response
          else
            JSON.parse(connector.previous_payload).merge(connector.errors)
          end
          instantiate_from_data(data)
        end

        def connector
          @connector ||= Hyperwallet::Api::Client.new
        end

        def success?
          connector.response.success?
        end

        def failed?
          !success?
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
          attributes = {}
          data.each_pair do |key, value|
            attributes.merge!({snakecase(key).to_sym => value})
          end
          self.send(:new, **attributes)
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