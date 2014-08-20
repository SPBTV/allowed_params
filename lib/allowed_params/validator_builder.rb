require_relative 'model'

module AllowedParams
  class ValidatorBuilder
    def initialize(controller)
      @controller = controller
      @params = {}
    end

    def validates(name, options = {})
      @params[name] = options
    end

    def validator
      params_options = @params
      controller_name = @controller.name.underscore

      Struct.new(*params_options.keys) do
        include Model
        attr_reader :params
        @controller_name = controller_name

        def self.model_name
          ActiveModel::Name.new(self, nil, @controller_name)
        end

        params_options.each_pair do |name, validations|
          if validations.present?
            validates name, validations
          end
        end

        def initialize(params = {})
          @params = params.except(*Array(AllowedParams.config.allowed_params)).except(:controller, :action)
          members.each do |name|
            send(:"#{name}=", params[name])
          end
        end

        def not_white_listed
          @params.keys.map(&:to_s) - members.map(&:to_s)
        end

      end
    end
  end
end
