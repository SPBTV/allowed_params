module AllowedParams
  module Model
    extend ActiveSupport::Concern
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Conversion
    include ActiveModel::Model
    include ActiveModel::Validations


    module ClassMethods
      def i18n_scope
        :allowed_params
      end
    end

    def i18n_scope
      self.class.i18n_scope
    end

    def new_record?
      true
    end

    def persisted?
      false
    end
  end
end
