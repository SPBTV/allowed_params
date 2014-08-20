require 'allowed_params/validator_builder'
require 'allowed_params/helper'

module AllowedParams
  include ActiveSupport::Configurable
  config.allowed_params = []
end
