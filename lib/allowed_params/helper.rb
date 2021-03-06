require_relative 'validator_builder'

module AllowedParams
  ValidationError = Class.new(ArgumentError)
  NotAllowedError = Class.new(ArgumentError)

  module Helper
    extend ActiveSupport::Concern

    module ClassMethods
      def params(opts={}, &block)
        builder = ::AllowedParams::ValidatorBuilder.new(self)
        builder.instance_eval(&block) if block_given?
        @request_params_validator = builder.validator
        @whitelist = opts.fetch(:whitelist, false)
      end

      def method_added(method)
        if instance_variable_get(:@request_params_validator).present?
          request_params_validator = @request_params_validator
          @request_params_validator = nil
          whitelist = @whitelist
          @whitelist = nil

          before_filter only: [method] do
            request_params = request_params_validator.new(params)
            if request_params.invalid?
              raise ValidationError, request_params.errors.full_messages.first
            end
            if whitelist && request_params.not_white_listed.present?
              raise NotAllowedError, request_params.not_white_listed.join(', ')
            end
          end
        end

        super
      end
    end
  end
end